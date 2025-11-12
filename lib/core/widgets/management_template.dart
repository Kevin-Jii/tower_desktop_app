import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/permission_gate.dart';
import '../providers/pagination_provider_base.dart';
import 'admin_table.dart';
import '../constants/ui_texts.dart';

class ManagementTemplate<T> extends StatelessWidget {
  final String title;
  final List<AdminTableColumn> columns;
  final Widget Function(T item, int index) rowBuilder;
  final VoidCallback? onCreate;
  final String? createPermission;
  final Widget provider;
  final Widget Function(BuildContext)? headerBuilder;

  const ManagementTemplate({
    super.key,
    required this.title,
    required this.columns,
    required this.rowBuilder,
    required this.provider,
    this.onCreate,
    this.createPermission,
    this.headerBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (onCreate != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: createPermission != null
                  ? PermissionGate(
                      required: createPermission!,
                      child: ElevatedButton.icon(
                        onPressed: onCreate,
                        icon: const Icon(Icons.add),
                        label: const Text(UITexts.commonAdd),
                      ),
                    )
                  : ElevatedButton.icon(
                      onPressed: onCreate,
                      icon: const Icon(Icons.add),
                      label: const Text(UITexts.commonAdd),
                    ),
            ),
        ],
      ),
      body: provider,
    );
  }
}

class ManagementPaginationTemplate<T, P extends PaginationProviderBase<T>>
    extends StatelessWidget {
  final String title;
  final List<AdminTableColumn> columns;
  final Widget Function(T item, int index) rowBuilder;
  final VoidCallback? onCreate;
  final String? createPermission;
  final P Function() providerBuilder;

  const ManagementPaginationTemplate({
    super.key,
    required this.title,
    required this.columns,
    required this.rowBuilder,
    required this.providerBuilder,
    this.onCreate,
    this.createPermission,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<P>(
      create: (_) {
        final provider = providerBuilder();
        provider.refresh(); // 异步加载第一页
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            if (onCreate != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: createPermission != null
                    ? PermissionGate(
                        required: createPermission!,
                        child: ElevatedButton.icon(
                          onPressed: onCreate,
                          icon: const Icon(Icons.add),
                          label: const Text(UITexts.commonAdd),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: onCreate,
                        icon: const Icon(Icons.add),
                        label: const Text(UITexts.commonAdd),
                      ),
              ),
          ],
        ),
        body: Consumer<P>(
          builder: (context, provider, child) {
            if (provider.loading && provider.items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text('错误: ${provider.error}'));
            }

            if (provider.items.isEmpty) {
              return const Center(child: Text('暂无数据'));
            }

            return AdminTable<T>(
              columns: columns,
              data: provider.items,
              rowBuilder: rowBuilder,
            );
          },
        ),
      ),
    );
  }
}
