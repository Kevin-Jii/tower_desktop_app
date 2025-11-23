import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import 'dingtalk_provider.dart';
import 'models.dart';
import '../store/store_provider.dart';
import '../store/models.dart';

class DingTalkManagementPage extends StatefulWidget {
  const DingTalkManagementPage({super.key});

  @override
  State<DingTalkManagementPage> createState() => _DingTalkManagementPageState();
}

class _DingTalkManagementPageState extends State<DingTalkManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DingTalkProvider>().loadRobots();
      context.read<StoreProvider>().loadStores(pageSize: 1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).micaBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '钉钉机器人管理',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          const Spacer(),
          FilledButton(
            onPressed: () => _openCreateDialog(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(FluentIcons.add, size: 16),
                SizedBox(width: 8),
                Text('新增机器人'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<DingTalkProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: ProgressRing());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!),
                const SizedBox(height: 16),
                Button(
                  onPressed: () => provider.loadRobots(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }
        if (provider.robots.isEmpty) {
          return const Center(child: Text('暂无钉钉机器人配置'));
        }
        return _buildRobotGrid(provider.robots);
      },
    );
  }

  Widget _buildRobotGrid(List<DingTalkRobot> robots) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: robots.length,
        itemBuilder: (context, index) {
          return _buildRobotCard(robots[index]);
        },
      ),
    );
  }

  Widget _buildRobotCard(DingTalkRobot robot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: robot.isEnabled ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    FluentIcons.robot,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        robot.name,
                        style: FluentTheme.of(context).typography.bodyStrong,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        robot.botType.toUpperCase(),
                        style: FluentTheme.of(context).typography.caption,
                      ),
                    ],
                  ),
                ),
                ToggleSwitch(
                  checked: robot.isEnabled,
                  onChanged: (value) => _toggleRobotStatus(robot),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow('ID', robot.id.toString()),
            if (robot.webhook.isNotEmpty)
              _buildInfoRow('Webhook', robot.webhook),
            _buildInfoRow('Client ID', robot.clientId),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  onPressed: () => _testPush(robot),
                  child: const Text('测试'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => _openEditDialog(robot),
                  child: const Text('编辑'),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () => _deleteRobot(robot),
                  child: const Text('删除'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: FluentTheme.of(context).typography.caption,
          ),
          Expanded(
            child: Text(
              value,
              style: FluentTheme.of(context).typography.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _openCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => RobotFormDialog(
        title: '新增钉钉机器人',
        onSubmit: (request) async {
          final provider = context.read<DingTalkProvider>();
          final success = await provider.createRobot(request);
          if (success) {
            Navigator.of(context).pop();
            await FluentInfoBarHelper.showSuccess(context, '机器人创建成功');
          } else {
            await FluentInfoBarHelper.showError(
              context,
              '创建失败: ${provider.error}',
            );
          }
        },
      ),
    );
  }

  void _openEditDialog(DingTalkRobot robot) {
    showDialog(
      context: context,
      builder: (context) => RobotFormDialog(
        title: '编辑钉钉机器人',
        robot: robot,
        onSubmit: (request) async {
          final provider = context.read<DingTalkProvider>();
          final updateRequest = UpdateDingTalkRobotRequest(
            botType: request.botType,
            webhook: request.webhook,
            secret: request.secret,
            clientId: request.clientId,
            clientSecret: request.clientSecret,
            agentId: request.agentId,
            robotCode: request.robotCode,
            storeId: request.storeId,
            isEnabled: request.isEnabled,
            msgType: request.msgType,
            openConversationId: request.openConversationId,
            remark: request.remark,
          );
          final success = await provider.updateRobot(robot, updateRequest);
          if (success) {
            Navigator.of(context).pop();
            await FluentInfoBarHelper.showSuccess(context, '机器人更新成功');
          } else {
            await FluentInfoBarHelper.showError(
              context,
              '更新失败: ${provider.error}',
            );
          }
        },
      ),
    );
  }

  void _deleteRobot(DingTalkRobot robot) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除机器人 "${robot.name}" 吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (result == true) {
      final provider = context.read<DingTalkProvider>();
      final success = await provider.deleteRobot(robot);
      if (success) {
        await FluentInfoBarHelper.showSuccess(context, '机器人删除成功');
      } else {
        await FluentInfoBarHelper.showError(
          context,
          '删除失败: ${provider.error}',
        );
      }
    }
  }

  void _toggleRobotStatus(DingTalkRobot robot) async {
    final provider = context.read<DingTalkProvider>();
    final updateRequest = UpdateDingTalkRobotRequest(
      isEnabled: !robot.isEnabled,
    );
    final success = await provider.updateRobot(robot, updateRequest);
    if (success) {
      await FluentInfoBarHelper.showSuccess(
        context,
        robot.isEnabled ? '机器人已禁用' : '机器人已启用',
      );
    } else {
      await FluentInfoBarHelper.showError(
        context,
        '操作失败: ${provider.error}',
      );
    }
  }

  void _testPush(DingTalkRobot robot) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: ProgressRing()),
    );
    
    try {
      final provider = context.read<DingTalkProvider>();
      final success = await provider.testPush(robot);
      Navigator.of(context).pop();
      
      if (success) {
        await FluentInfoBarHelper.showSuccess(context, '测试推送成功');
      } else {
        await FluentInfoBarHelper.showError(
          context,
          '测试失败: ${provider.error}',
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      await FluentInfoBarHelper.showError(context, '测试失败: $e');
    }
  }
}

/// 机器人表单对话框
class RobotFormDialog extends StatefulWidget {
  final String title;
  final DingTalkRobot? robot;
  final Function(CreateDingTalkRobotRequest) onSubmit;

  const RobotFormDialog({
    super.key,
    required this.title,
    this.robot,
    required this.onSubmit,
  });

  @override
  State<RobotFormDialog> createState() => _RobotFormDialogState();
}

class _RobotFormDialogState extends State<RobotFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _webhookCtrl = TextEditingController();
  final _secretCtrl = TextEditingController();
  final _clientIdCtrl = TextEditingController();
  final _clientSecretCtrl = TextEditingController();
  final _agentIdCtrl = TextEditingController();
  final _robotCodeCtrl = TextEditingController();
  final _openConversationIdCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();

  String _botType = 'webhook';
  int? _storeId;
  bool _isEnabled = true;
  String _msgType = 'markdown';
  List<Store> _stores = [];

  @override
  void initState() {
    super.initState();
    if (widget.robot != null) {
      final r = widget.robot!;
      _botType = r.botType;
      _webhookCtrl.text = r.webhook;
      _secretCtrl.text = r.secret;
      _clientIdCtrl.text = r.clientId;
      _clientSecretCtrl.text = r.clientSecret;
      _agentIdCtrl.text = r.agentId?.toString() ?? '';
      _robotCodeCtrl.text = r.robotCode;
      _openConversationIdCtrl.text = r.openConversationId ?? '';
      _remarkCtrl.text = r.remark ?? '';
      _storeId = r.storeId;
      _isEnabled = r.isEnabled;
      _msgType = r.msgType;
    }
    _loadStores();
  }

  Future<void> _loadStores() async {
    final storeProvider = context.read<StoreProvider>();
    await storeProvider.loadStores(pageSize: 1000);
    setState(() {
      _stores = storeProvider.stores;
    });
  }

  @override
  void dispose() {
    _webhookCtrl.dispose();
    _secretCtrl.dispose();
    _clientIdCtrl.dispose();
    _clientSecretCtrl.dispose();
    _agentIdCtrl.dispose();
    _robotCodeCtrl.dispose();
    _openConversationIdCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final request = CreateDingTalkRobotRequest(
      name: '',
      botType: _botType,
      webhook: _webhookCtrl.text,
      secret: _secretCtrl.text,
      clientId: _clientIdCtrl.text,
      clientSecret: _clientSecretCtrl.text,
      agentId: int.tryParse(_agentIdCtrl.text),
      robotCode: _robotCodeCtrl.text,
      storeId: _storeId,
      isEnabled: _isEnabled,
      msgType: _msgType,
      openConversationId: _openConversationIdCtrl.text.isEmpty
          ? null
          : _openConversationIdCtrl.text,
      remark: _remarkCtrl.text,
    );
    widget.onSubmit(request);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 600,
        height: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoLabel(
                  label: '机器人类型',
                  child: ComboBox<String>(
                    value: _botType,
                    items: const [
                      ComboBoxItem(value: 'webhook', child: Text('Webhook')),
                      ComboBoxItem(value: 'stream', child: Text('Stream')),
                    ],
                    onChanged: (value) {
                      setState(() => _botType = value ?? 'webhook');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (_botType == 'webhook') ...[
                  InfoLabel(
                    label: 'Webhook 地址 *',
                    child: TextBox(
                      controller: _webhookCtrl,
                      placeholder: 'https://oapi.dingtalk.com/robot/send?access_token=xxx',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: '签名密钥 (可选)',
                    child: TextBox(
                      controller: _secretCtrl,
                      placeholder: 'SECxxxxxx',
                    ),
                  ),
                ] else ...[
                  InfoLabel(
                    label: 'Client ID (AppKey) *',
                    child: TextBox(
                      controller: _clientIdCtrl,
                      placeholder: '请输入 Client ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: 'Client Secret *',
                    child: TextBox(
                      controller: _clientSecretCtrl,
                      placeholder: '请输入 Client Secret',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: 'Agent ID (可选)',
                    child: TextBox(
                      controller: _agentIdCtrl,
                      placeholder: '请输入 Agent ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: '机器人编码 (RobotCode)',
                    child: TextBox(
                      controller: _robotCodeCtrl,
                      placeholder: '钉钉分配的机器人编码',
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                InfoLabel(
                  label: '消息类型',
                  child: ComboBox<String>(
                    value: _msgType,
                    items: const [
                      ComboBoxItem(value: 'markdown', child: Text('Markdown')),
                      ComboBoxItem(value: 'text', child: Text('文本')),
                    ],
                    onChanged: (value) {
                      setState(() => _msgType = value ?? 'markdown');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '通知群号 (可选)',
                  child: TextBox(
                    controller: _openConversationIdCtrl,
                    placeholder: '请输入钉钉群的 open_conversation_id',
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '备注',
                  child: TextBox(
                    controller: _remarkCtrl,
                    placeholder: '请输入备注信息',
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 16),
                InfoLabel(
                  label: '所属门店 (可选)',
                  child: ComboBox<int>(
                    value: _storeId,
                    placeholder: const Text('请选择门店'),
                    items: _stores
                        .map((store) => ComboBoxItem<int>(
                              value: store.id,
                              child: Text(store.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _storeId = value);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Checkbox(
                  checked: _isEnabled,
                  onChanged: (v) => setState(() => _isEnabled = v ?? true),
                  content: const Text('是否启用'),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('保存'),
        ),
      ],
    );
  }
}
