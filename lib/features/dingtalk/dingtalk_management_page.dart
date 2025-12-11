import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../../core/widgets/list_item_card.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          const Icon(FluentIcons.robot, size: 24),
          const SizedBox(width: 12),
          Text(
            '钉钉机器人管理',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          const Spacer(),
          FilledButton(
            onPressed: () => _openCreateDialog(),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.add, size: 14),
                SizedBox(width: 6),
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
                Icon(FluentIcons.error, size: 48, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text(provider.error!, style: TextStyle(color: Colors.grey[100])),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.robot, size: 64, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text('暂无机器人配置', style: TextStyle(color: Colors.grey[100])),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => _openCreateDialog(),
                  child: const Text('添加第一个机器人'),
                ),
              ],
            ),
          );
        }
        return _buildRobotList(provider.robots);
      },
    );
  }
  Widget _buildRobotList(List<DingTalkRobot> robots) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: robots.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildRobotCard(robots[index]),
        );
      },
    );
  }
  Widget _buildRobotCard(DingTalkRobot robot) {
    final stores = context.watch<StoreProvider>().stores;
    final storeName =
        stores.where((s) => s.id == robot.storeId).firstOrNull?.name ?? '未绑定门店';
    return ListItemCard(
      icon: FluentIcons.robot,
      iconColor: Colors.blue,
      title: storeName,
      subtitle: _formatWebhook(robot.webhook),
      description: robot.remark,
      isEnabled: robot.isEnabled,
      onStatusChanged: (value) => _toggleRobotStatus(robot),
      actions: [
        ListItemAction(
          icon: FluentIcons.send,
          label: '测试',
          tooltip: '测试推送',
          onPressed: () => _testPush(robot),
        ),
        ListItemAction(
          icon: FluentIcons.edit,
          label: '编辑',
          tooltip: '编辑机器人',
          onPressed: () => _openEditDialog(robot),
        ),
        ListItemAction(
          icon: FluentIcons.delete,
          label: '删除',
          tooltip: '删除机器人',
          color: Colors.red,
          onPressed: () => _deleteRobot(robot),
        ),
      ],
    );
  }
  String _formatWebhook(String webhook) {
    if (webhook.isEmpty) return '未配置 Webhook';
    final tokenMatch = RegExp(r'access_token=([a-zA-Z0-9]+)').firstMatch(webhook);
    if (tokenMatch != null) {
      final token = tokenMatch.group(1)!;
      final shortToken = token.length > 8 ? '${token.substring(0, 8)}...' : token;
      return 'Webhook: $shortToken';
    }
    return webhook.length > 40 ? '${webhook.substring(0, 40)}...' : webhook;
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
            botType: 'webhook',
            webhook: request.webhook,
            secret: request.secret,
            storeId: request.storeId,
            isEnabled: request.isEnabled,
            msgType: request.msgType,
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
    final stores = context.read<StoreProvider>().stores;
    final storeName =
        stores.where((s) => s.id == robot.storeId).firstOrNull?.name ?? '该机器人';
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除 "$storeName" 的机器人吗？'),
        actions: [
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
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
  final _webhookCtrl = TextEditingController();
  final _secretCtrl = TextEditingController();
  final _remarkCtrl = TextEditingController();
  int? _storeId;
  String _msgType = 'markdown';
  List<Store> _stores = [];
  @override
  void initState() {
    super.initState();
    if (widget.robot != null) {
      final r = widget.robot!;
      _webhookCtrl.text = r.webhook;
      _secretCtrl.text = r.secret;
      _remarkCtrl.text = r.remark ?? '';
      _storeId = r.storeId;
      _msgType = r.msgType.isNotEmpty ? r.msgType : 'markdown';
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
    _remarkCtrl.dispose();
    super.dispose();
  }
  void _submit() {
    if (_webhookCtrl.text.trim().isEmpty) {
      FluentInfoBarHelper.showError(context, '请输入 Webhook 地址');
      return;
    }
    final request = CreateDingTalkRobotRequest(
      name: '',
      botType: 'webhook',
      webhook: _webhookCtrl.text.trim(),
      secret: _secretCtrl.text.trim(),
      storeId: _storeId,
      isEnabled: true,
      msgType: _msgType,
      remark: _remarkCtrl.text.trim(),
    );
    widget.onSubmit(request);
  }
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: '所属门店',
              child: ComboBox<int>(
                value: _storeId,
                placeholder: const Text('请选择门店'),
                isExpanded: true,
                items: _stores
                    .map((store) => ComboBoxItem<int>(
                          value: store.id,
                          child: Text(store.name),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _storeId = value),
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Webhook 地址',
              child: TextBox(
                controller: _webhookCtrl,
                placeholder: 'https:
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '签名密钥（可选）',
              child: TextBox(
                controller: _secretCtrl,
                placeholder: 'SECxxxxxx',
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '消息格式',
              child: ComboBox<String>(
                value: _msgType,
                isExpanded: true,
                items: const [
                  ComboBoxItem(value: 'markdown', child: Text('Markdown')),
                  ComboBoxItem(value: 'text', child: Text('纯文本')),
                ],
                onChanged: (value) =>
                    setState(() => _msgType = value ?? 'markdown'),
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: '备注（可选）',
              child: TextBox(
                controller: _remarkCtrl,
                placeholder: '请输入备注信息',
              ),
            ),
          ],
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
