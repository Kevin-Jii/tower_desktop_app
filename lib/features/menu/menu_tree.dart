import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/menu_types.dart';
import '../../core/theme/tower_colors.dart';
import 'menu_provider.dart';
import 'models.dart';

class MenuTree extends StatelessWidget {
  final void Function(MenuItem item)? onSelect;

  const MenuTree({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final towerColors = Theme.of(context).extension<TowerColors>();
    final accent = Theme.of(context).colorScheme.primary;
    final borderColor = towerColors?.sideBarBorder ?? Colors.grey.shade300;

    return Consumer<MenuProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '加载失败: ${provider.error}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                FilledButton(onPressed: provider.load, child: const Text('重试')),
              ],
            ),
          );
        }
        if (provider.tree.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          color: towerColors?.sideBarBackground ?? Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 12,
                    top: 12,
                    bottom: 16,
                  ),
                  children: _buildMenuWidgets(
                    provider: provider,
                    towerColors: towerColors,
                    accent: accent,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildMenuWidgets({
    required MenuProvider provider,
    required TowerColors? towerColors,
    required Color accent,
  }) {
    final widgets = <Widget>[];
    final roots = provider.tree;

    for (int index = 0; index < roots.length; index++) {
      final section = roots[index];
      final hasChildren = section.children.isNotEmpty;
      // 如果有子节点，无论 type 是什么，都当作目录处理
      final isDirectory = hasChildren;

      if (isDirectory) {
        if (widgets.isNotEmpty) {
          widgets.add(const SizedBox(height: 16));
        }
        widgets.add(_MenuSectionHeader(
          title: section.title,
          towerColors: towerColors,
        ));
        widgets.addAll(_buildChildren(
          nodes: section.children,
          provider: provider,
          towerColors: towerColors,
          accent: accent,
          depth: 0,
        ));
      } else {
        widgets.add(_MenuLeafTile(
          item: section,
          selected: provider.selected?.id == section.id,
          towerColors: towerColors,
          accent: accent,
          depth: 0,
          onTap: () {
            provider.select(section);
            onSelect?.call(section);
          },
        ));
      }
    }

    return widgets;
  }

  List<Widget> _buildChildren({
    required List<MenuItem> nodes,
    required MenuProvider provider,
    required TowerColors? towerColors,
    required Color accent,
    required int depth,
  }) {
    final widgets = <Widget>[];

    for (final node in nodes) {
      final hasChildren = node.children.isNotEmpty;

      // 如果有子节点，无论 type 是什么，都当作目录处理
      if (hasChildren) {
        widgets.add(_MenuSubsectionHeader(
          title: node.title,
          towerColors: towerColors,
          depth: depth + 1,
        ));
        widgets.addAll(_buildChildren(
          nodes: node.children,
          provider: provider,
          towerColors: towerColors,
          accent: accent,
          depth: depth + 1,
        ));
      } else {
        widgets.add(_MenuLeafTile(
          item: node,
          selected: provider.selected?.id == node.id,
          towerColors: towerColors,
          accent: accent,
          depth: depth,
          onTap: () {
            provider.select(node);
            onSelect?.call(node);
          },
        ));
      }
    }

    return widgets;
  }
}

class _SidebarBrand extends StatelessWidget {
  final Color accent;
  final TowerColors? towerColors;

  const _SidebarBrand({
    required this.accent,
    required this.towerColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.restaurant_menu,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}

class _MenuSectionHeader extends StatelessWidget {
  final String title;
  final TowerColors? towerColors;

  const _MenuSectionHeader({
    required this.title,
    required this.towerColors,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor =
        towerColors?.navBarForeground ?? const Color(0xFF4B5563);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: .4,
          color: baseColor.withOpacity(.6),
        ),
      ),
    );
  }
}

class _MenuSubsectionHeader extends StatelessWidget {
  final String title;
  final TowerColors? towerColors;
  final int depth;

  const _MenuSubsectionHeader({
    required this.title,
    required this.towerColors,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor =
        towerColors?.navBarForeground ?? const Color(0xFF4B5563);
    return Padding(
      padding: EdgeInsets.fromLTRB(4 + depth * 14.0, 10, 4, 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: baseColor.withOpacity(.55),
        ),
      ),
    );
  }
}

class _MenuLeafTile extends StatelessWidget {
  final MenuItem item;
  final bool selected;
  final TowerColors? towerColors;
  final Color accent;
  final int depth;
  final VoidCallback onTap;

  const _MenuLeafTile({
    required this.item,
    required this.selected,
    required this.towerColors,
    required this.accent,
    required this.depth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseTextColor =
        towerColors?.navBarForeground.withOpacity(.8) ??
            Colors.blueGrey.shade700;
    final iconColor = selected ? accent : baseTextColor;
    final backgroundColor = selected ? accent.withOpacity(.15) : Colors.transparent;

    return Padding(
      padding: EdgeInsets.only(left: depth * 14.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 2.5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: accent.withOpacity(.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: selected ? 4 : 2,
                height: selected ? 28 : 24,
                decoration: BoxDecoration(
                  color: selected ? accent : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(selected ? 0 : 2),
                    bottomRight: Radius.circular(selected ? 0 : 2),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: selected
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            TdIconMapper.build(
                              item.icon,
                              size: 16,
                              color: iconColor.withOpacity(.3),
                            ),
                            TdIconMapper.build(
                              item.icon,
                              size: 16,
                              color: iconColor,
                            ),
                          ],
                        )
                      : TdIconMapper.build(
                          item.icon,
                          size: 16,
                          color: iconColor,
                        ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? accent : baseTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
