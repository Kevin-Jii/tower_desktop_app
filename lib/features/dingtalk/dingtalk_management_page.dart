import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/design_tokens.dart';
import 'dingtalk_provider.dart';
import 'models.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: DesignTokens.shadowSm,
      ),
      child: Row(
        children: [
          Text(
            '钉钉机器人管理',
            style: DesignTokens.heading2
                .copyWith(color: theme.textTheme.bodyLarge?.color),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => _openCreateDialog(),
            icon: const Icon(Icons.add),
            label: const Text('新增机器人'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DesignTokens.brandPrimary,
              foregroundColor: Colors.white,
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
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!,
                    style: TextStyle(color: Colors.red.shade600)),
                const SizedBox(height: 16),
                ElevatedButton(
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
        return _buildCardGrid(provider.robots);
      },
    );
  }

  Widget _buildCardGrid(List<DingTalkRobot> robots) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.3,
          crossAxisSpacing: DesignTokens.spaceMd,
          mainAxisSpacing: DesignTokens.spaceMd,
        ),
        itemCount: robots.length,
        itemBuilder: (context, index) {
          final robot = robots[index];
          return Align(
            alignment: Alignment.topCenter,
            child: IntrinsicHeight(
              child: _buildRobotCard(robot),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRobotCard(DingTalkRobot robot) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      shadowColor: Colors.blue.shade100,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.blue.shade50],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: robot.isEnabled
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.smart_toy,
                        color: robot.isEnabled
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(robot.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF222B45)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(robot.botType.toUpperCase(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                        Icons.info_outline, 'ID', robot.id.toString()),
                    if (robot.webhook.isNotEmpty)
                      _buildInfoRow(Icons.link, 'Webhook', robot.webhook),
                    _buildInfoRow(
                        Icons.fingerprint, 'Client ID', robot.clientId),
                    if (robot.agentId != null)
                      _buildInfoRow(
                          Icons.settings, 'Agent ID', robot.agentId.toString()),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _testPush(robot),
                      icon: const Icon(Icons.send, size: 16),
                      label: const Text('测试', style: TextStyle(fontSize: 13)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        side: BorderSide(color: Colors.green.shade300),
                        foregroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _openEditDialog(robot),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('编辑', style: TextStyle(fontSize: 13)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        backgroundColor: DesignTokens.brandPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => _deleteRobot(robot),
                      icon: const Icon(Icons.delete, size: 16),
                      label: const Text('删除', style: TextStyle(fontSize: 13)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        side: BorderSide(color: Colors.red.shade300),
                        foregroundColor: Colors.red.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: ElevatedButton(
              onPressed: () => _toggleRobotStatus(robot),
              style: ElevatedButton.styleFrom(
                backgroundColor: robot.isEnabled
                    ? Colors.red.shade400
                    : Colors.green.shade400,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 0,
              ),
              child: Text(robot.isEnabled ? '禁用' : '启用',
                  style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text('$label: ',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('机器人创建成功')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('创建失败: ${provider.error}'),
                backgroundColor: Colors.red,
              ),
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
            name: request.name,
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
            remark: request.remark,
          );
          final success = await provider.updateRobot(robot, updateRequest);
          if (success) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('机器人更新成功')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('更新失败: ${provider.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  void _deleteRobot(DingTalkRobot robot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除机器人 "${robot.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final provider = context.read<DingTalkProvider>();
              final success = await provider.deleteRobot(robot);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('机器人删除成功')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('删除失败: ${provider.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _toggleRobotStatus(DingTalkRobot robot) async {
    final provider = context.read<DingTalkProvider>();
    final updateRequest = UpdateDingTalkRobotRequest(
      isEnabled: !robot.isEnabled,
    );
    final success = await provider.updateRobot(robot, updateRequest);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(robot.isEnabled ? '机器人已禁用' : '机器人已启用'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('操作失败: ${provider.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _testPush(DingTalkRobot robot) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final provider = context.read<DingTalkProvider>();
      final success = await provider.testPush(robot);
      Navigator.of(context).pop();
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('测试推送成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('测试失败: ${provider.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('测试失败: $e'), backgroundColor: Colors.red),
      );
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _tokenController;
  late TextEditingController _remarkController;
  late TextEditingController _webhookController;
  late TextEditingController _secretController;
  late TextEditingController _clientIdController;
  late TextEditingController _clientSecretController;
  late TextEditingController _agentIdController;
  late TextEditingController _robotCodeController;

  String _botType = 'webhook';
  int? _storeId;
  bool _isEnabled = true;
  String _msgType = 'markdown';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.robot?.name ?? '');
    _tokenController = TextEditingController(text: widget.robot?.token ?? '');
    _remarkController = TextEditingController(text: widget.robot?.remark ?? '');
    _webhookController = TextEditingController(text: widget.robot?.webhook ?? '');
    _secretController = TextEditingController(text: widget.robot?.secret ?? '');
    _clientIdController = TextEditingController(text: widget.robot?.clientId ?? '');
    _clientSecretController = TextEditingController(text: widget.robot?.clientSecret ?? '');
    _agentIdController = TextEditingController(text: widget.robot?.agentId?.toString() ?? '');
    _robotCodeController = TextEditingController(text: widget.robot?.robotCode ?? '');

    if (widget.robot != null) {
      _botType = widget.robot!.botType;
      _storeId = widget.robot!.storeId;
      _isEnabled = widget.robot!.isEnabled;
      _msgType = widget.robot!.msgType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tokenController.dispose();
    _remarkController.dispose();
    _webhookController.dispose();
    _secretController.dispose();
    _clientIdController.dispose();
    _clientSecretController.dispose();
    _agentIdController.dispose();
    _robotCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 600,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '机器人名称 *',
                    hintText: '请输入机器人名称',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入机器人名称';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _botType,
                  decoration: const InputDecoration(
                    labelText: '机器人类型',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'webhook', child: Text('Webhook')),
                    DropdownMenuItem(value: 'stream', child: Text('Stream')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _botType = value ?? 'webhook';
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (_botType == 'webhook') ...[
                  TextFormField(
                    controller: _webhookController,
                    decoration: const InputDecoration(
                      labelText: 'Webhook 地址 *',
                      hintText: 'https://oapi.dingtalk.com/robot/send?access_token=xxx',
                    ),
                    validator: (value) {
                      if (_botType == 'webhook' && (value == null || value.isEmpty)) {
                        return '请输入 Webhook 地址';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _secretController,
                    decoration: const InputDecoration(
                      labelText: '签名密钥 (可选)',
                      hintText: 'SECxxxxxx',
                    ),
                  ),
                ] else ...[
                  TextFormField(
                    controller: _clientIdController,
                    decoration: const InputDecoration(
                      labelText: 'Client ID (AppKey) *',
                      hintText: '请输入 Client ID',
                    ),
                    validator: (value) {
                      if (_botType == 'stream' && (value == null || value.isEmpty)) {
                        return '请输入 Client ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _clientSecretController,
                    decoration: const InputDecoration(
                      labelText: 'Client Secret *',
                      hintText: '请输入 Client Secret',
                    ),
                    validator: (value) {
                      if (_botType == 'stream' && (value == null || value.isEmpty)) {
                        return '请输入 Client Secret';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _agentIdController,
                    decoration: const InputDecoration(
                      labelText: 'Agent ID (可选)',
                      hintText: '请输入 Agent ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _robotCodeController,
                    decoration: const InputDecoration(
                      labelText: '机器人编码 (RobotCode)',
                      hintText: '钉钉分配的机器人编码',
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _msgType,
                  decoration: const InputDecoration(
                    labelText: '消息类型',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'markdown', child: Text('Markdown')),
                    DropdownMenuItem(value: 'text', child: Text('文本')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _msgType = value ?? 'markdown';
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _remarkController,
                  decoration: const InputDecoration(
                    labelText: '备注',
                    hintText: '请输入备注信息',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _storeId,
                  decoration: const InputDecoration(
                    labelText: '所属门店 (可选)',
                  ),
                  items: [
                    const DropdownMenuItem<int>(value: null, child: Text('全局')),
                    if (_storeId != null)
                      DropdownMenuItem<int>(value: _storeId, child: Text('门店 $_storeId')),
                    // TODO: 这里应该从后端加载门店列表
                  ],
                  onChanged: (value) {
                    setState(() {
                      _storeId = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('是否启用'),
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final request = CreateDingTalkRobotRequest(
                name: _nameController.text,
                botType: _botType,
                webhook: _webhookController.text,
                secret: _secretController.text,
                clientId: _clientIdController.text,
                clientSecret: _clientSecretController.text,
                agentId: int.tryParse(_agentIdController.text),
                robotCode: _robotCodeController.text,
                storeId: _storeId,
                isEnabled: _isEnabled,
                msgType: _msgType,
                remark: _remarkController.text,
              );
              widget.onSubmit(request);
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
