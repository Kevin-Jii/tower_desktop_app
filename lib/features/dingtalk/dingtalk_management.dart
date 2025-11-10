import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dingtalk_provider.dart';
import 'dingtalk_api.dart';
import 'models.dart';
import '../../core/widgets/management_template.dart';
import '../../core/widgets/form_dialog_builder.dart';
import '../../core/widgets/admin_table.dart';
import '../../core/constants/ui_texts.dart';
import '../../core/network/api_client.dart';

class DingTalkManagement extends StatelessWidget {
  const DingTalkManagement({super.key});

  static final _columns = <AdminTableColumn>[
    const AdminTableColumn(label: '名称'),
    const AdminTableColumn(label: 'Webhook'),
    const AdminTableColumn(width: 80, label: '状态'),
    const AdminTableColumn(label: '操作', alignment: Alignment.centerRight),
  ];

  static Future<void> _loadRobots(BuildContext context) async {
    final api = DingTalkApi(ApiClient());
    await context.read<DingTalkProvider>().loadData(() async {
      final response = await api.list();
      return response.when(
        success: (data) => data ?? [],
        error: (message, code) {
          throw Exception(message);
        },
      );
    });
  }

  static Widget _buildRow(DingTalkRobot robot, int index) {
    return Row(
      children: [
        Expanded(child: Text(robot.name)),
        Expanded(child: Text(robot.webhook)),
        SizedBox(width: 80, child: _buildStatusTag(robot.isActive)),
        _buildActions(robot),
      ],
    );
  }

  static Widget _buildActions(DingTalkRobot robot) {
    return Consumer<DingTalkProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () => _handleEdit(context, robot),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
              onPressed: () => _handleDelete(context, robot),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildStatusTag(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isActive ? '启用' : '禁用',
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Future<void> _handleCreate(BuildContext context) async {
    const fields = <FormFieldConfig>[
      FormFieldConfig(key: 'name', label: '机器人名称', required: true, maxLength: 50),
      FormFieldConfig(key: 'webhook', label: 'Webhook地址', required: true, maxLength: 200),
      FormFieldConfig(key: 'secret', label: '密钥', maxLength: 100),
    ];

    final result = await FormDialog.show(context, title: '新建钉钉机器人', fields: fields);
    if (result != null) {
      try {
        final api = DingTalkApi(ApiClient());
        final response = await api.create(
          CreateDingTalkRobotRequest(
            name: result['name']!,
            webhook: result['webhook']!,
            secret: result['secret'],
          ),
        );

        response.when(
          success: (_) async {
            await _loadRobots(context);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('创建成功')),
              );
            }
          },
          error: (message, code) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('创建失败: $message'), backgroundColor: Colors.red),
              );
            }
          },
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('创建失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  static Future<void> _handleEdit(BuildContext context, DingTalkRobot robot) async {
    final fields = <FormFieldConfig>[
      FormFieldConfig(key: 'name', label: '机器人名称', initialValue: robot.name, required: true),
      FormFieldConfig(key: 'webhook', label: 'Webhook地址', initialValue: robot.webhook, required: true),
      FormFieldConfig(key: 'secret', label: '密钥', initialValue: robot.secret),
    ];

    final result = await FormDialog.show(context, title: '编辑钉钉机器人', fields: fields);
    if (result != null) {
      try {
        final api = DingTalkApi(ApiClient());
        final response = await api.update(
          robot.id!,
          UpdateDingTalkRobotRequest(
            name: result['name']!,
            webhook: result['webhook']!,
            secret: result['secret'],
          ),
        );

        response.when(
          success: (_) async {
            await _loadRobots(context);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('更新成功')),
              );
            }
          },
          error: (message, code) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('更新失败: $message'), backgroundColor: Colors.red),
              );
            }
          },
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('更新失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  static Future<void> _handleDelete(BuildContext context, DingTalkRobot robot) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除钉钉机器人 "${robot.name}" 吗?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final api = DingTalkApi(ApiClient());
        final response = await api.delete(robot.id!);

        response.when(
          success: (_) async {
            await _loadRobots(context);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('删除成功')),
              );
            }
          },
          error: (message, code) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('删除失败: $message'), backgroundColor: Colors.red),
              );
            }
          },
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('删除失败: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DingTalkProvider()..loadData(() {
        final api = DingTalkApi(ApiClient());
        return api.list().then((response) => response.when(
          success: (data) => data ?? [],
          error: (message, code) => throw Exception(message),
        ));
      }),
      child: Builder(
        builder: (context) {
          return ManagementTemplate<DingTalkRobot>(
            title: '钉钉机器人管理',
            createPermission: 'system:dingtalk:add',
            onCreate: () => _handleCreate(context),
            columns: _columns,
            rowBuilder: _buildRow,
          );
        },
      ),
    );
  }
}

class DingTalkProvider extends ChangeNotifier with ListProviderMixin<DingTalkRobot> {}
