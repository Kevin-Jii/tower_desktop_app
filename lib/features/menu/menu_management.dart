import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/network/base_provider.dart';
import '../../core/widgets/management_template.dart';
import '../../core/widgets/admin_table.dart';

class MenuManageProvider extends ChangeNotifier with ListProviderMixin<dynamic> {}

class MenuManagement extends StatelessWidget {
  const MenuManagement({super.key});

  static final _columns = <AdminTableColumn>[
    const AdminTableColumn(label: '菜单名称'),
    const AdminTableColumn(label: '类型'),
    const AdminTableColumn(label: '路径'),
    const AdminTableColumn(label: '操作'),
  ];

  static Widget _buildRow(dynamic item, int index) {
    return const Row(
      children: [
        Expanded(child: Text('菜单项')),
        Expanded(child: Text('类型')),
        Expanded(child: Text('路径')),
        Expanded(child: Text('操作')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuManageProvider(),
      child: Builder(
        builder: (context) {
          return ManagementTemplate(
            title: '菜单管理',
            createPermission: 'system:menu:add',
            onCreate: () {},
            columns: _columns,
            rowBuilder: _buildRow,
            provider: ChangeNotifierProvider(
              create: (_) => MenuManageProvider(),
              child: const Center(child: Text('菜单管理功能待实现')),
            ),
          );
        },
      ),
    );
  }
}
