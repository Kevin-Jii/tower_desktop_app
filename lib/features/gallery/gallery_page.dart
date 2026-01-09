import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import '../../core/widgets/fluent_info_bar.dart';
import '../auth/session_manager.dart';
import 'gallery_provider.dart';
import 'models.dart';
class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}
class _GalleryPageState extends State<GalleryPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryProvider>().loadImages(refresh: true);
    });
    _scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final provider = context.read<GalleryProvider>();
      if (!provider.loading && provider.hasMore) {
        provider.loadImages();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          _buildHeader(),
          _buildToolbar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
  Widget _buildHeader() {
    final provider = context.watch<GalleryProvider>();
    final hasSelection = provider.selectedIds.isNotEmpty;
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
          const Icon(FluentIcons.picture_library, size: 24),
          const SizedBox(width: 12),
          Text('图库管理', style: FluentTheme.of(context).typography.subtitle),
          const SizedBox(width: 12),
          Text(
            '共 ${provider.total} 张',
            style: TextStyle(color: Colors.grey[100], fontSize: 13),
          ),
          if (hasSelection) ...[
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '已选择 ${provider.selectedIds.length} 张',
                style: TextStyle(color: Colors.blue, fontSize: 13),
              ),
            ),
            const SizedBox(width: 8),
            Button(
              onPressed: () => provider.clearSelection(),
              child: const Text('取消'),
            ),
            const SizedBox(width: 8),
            Button(
              onPressed: () => _batchDelete(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.delete, size: 14, color: Colors.red),
                  const SizedBox(width: 4),
                  Text('批量删除', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          const Spacer(),
          FilledButton(
            onPressed: () => _showUploadDialog(),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FluentIcons.upload, size: 14),
                SizedBox(width: 6),
                Text('上传图片'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: ComboBox<String>(
              value: _selectedCategory,
              placeholder: const Text('全部分类'),
              isExpanded: true,
              items: [
                const ComboBoxItem(value: null, child: Text('全部分类')),
                ...GalleryCategory.labels.entries.map(
                  (e) => ComboBoxItem(value: e.key, child: Text(e.value)),
                ),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value);
                context.read<GalleryProvider>().setCategory(value);
              },
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 250,
            child: TextBox(
              controller: _searchController,
              placeholder: '搜索图片...',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(FluentIcons.search, size: 14),
              ),
              suffix: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(FluentIcons.clear, size: 12),
                      onPressed: () {
                        _searchController.clear();
                        context.read<GalleryProvider>().search(null);
                      },
                    )
                  : null,
              onSubmitted: (value) {
                context.read<GalleryProvider>().search(value.isEmpty ? null : value);
              },
            ),
          ),
          const SizedBox(width: 8),
          Button(
            onPressed: () {
              final keyword = _searchController.text.trim();
              context.read<GalleryProvider>().search(keyword.isEmpty ? null : keyword);
            },
            child: const Text('搜索'),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(FluentIcons.refresh, size: 16),
            onPressed: () {
              context.read<GalleryProvider>().loadImages(refresh: true);
            },
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    return Consumer<GalleryProvider>(
      builder: (context, provider, _) {
        if (provider.loading && provider.images.isEmpty) {
          return const Center(child: ProgressRing());
        }
        if (provider.error != null && provider.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.error, size: 48, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text(provider.error!, style: TextStyle(color: Colors.grey[100])),
                const SizedBox(height: 16),
                Button(
                  onPressed: () => provider.loadImages(refresh: true),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }
        if (provider.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.picture_library, size: 64, color: Colors.grey[80]),
                const SizedBox(height: 16),
                Text('暂无图片', style: TextStyle(color: Colors.grey[100])),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => _showUploadDialog(),
                  child: const Text('上传第一张图片'),
                ),
              ],
            ),
          );
        }
        return _buildImageGrid(provider);
      },
    );
  }
  Widget _buildImageGrid(GalleryProvider provider) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: provider.images.length + (provider.loading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= provider.images.length) {
          return const Center(child: ProgressRing());
        }
        return _buildImageCard(provider.images[index], provider);
      },
    );
  }
  Widget _buildImageCard(GalleryImage image, GalleryProvider provider) {
    final isSelected = provider.selectedIds.contains(image.id);
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _showImageDetail(image),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? Colors.blue
                    : (isDark ? Colors.grey[100] : Colors.grey[40]),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: _buildAuthImage(image.thumbUrl ?? image.url),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: GestureDetector(
              onTap: () => provider.toggleSelection(image.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey[80],
                  ),
                ),
                child: isSelected
                    ? const Icon(FluentIcons.check_mark, size: 14, color: Colors.white)
                    : null,
              ),
            ),
          ),
          if (image.category != null)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  GalleryCategory.labels[image.category] ?? image.category!,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(7)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      image.name ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildIconBtn(FluentIcons.copy, () => _copyUrl(image)),
                  const SizedBox(width: 4),
                  _buildIconBtn(FluentIcons.edit, () => _showEditDialog(image)),
                  const SizedBox(width: 4),
                  _buildIconBtn(FluentIcons.delete, () => _deleteImage(image),
                      color: Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPlaceholder({String? errorMsg}) {
    return Container(
      color: Colors.grey[30],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FluentIcons.photo2, size: 32, color: Colors.grey[80]),
            if (errorMsg != null) ...[
              const SizedBox(height: 4),
              Text(
                errorMsg,
                style: TextStyle(fontSize: 10, color: Colors.grey[100]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
  Widget _buildAuthImage(String? url, {BoxFit fit = BoxFit.cover}) {
    if (url == null || url.isEmpty) {
      return _buildPlaceholder();
    }
    final isExternalUrl = url.startsWith('http:
    final token = isExternalUrl ? null : SessionManager().token;
    return Image.network(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: ProgressRing(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (_, error, __) => _buildPlaceholder(errorMsg: '加载失败'),
    );
  }
  Widget _buildIconBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 12, color: color ?? Colors.grey[140]),
      ),
    );
  }
  void _showUploadDialog() {
    String selectedCategory = GalleryCategory.other;
    final remarkController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('上传图片'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLabel(
                label: '分类',
                child: StatefulBuilder(
                  builder: (context, setState) => ComboBox<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    items: GalleryCategory.labels.entries
                        .map((e) => ComboBoxItem(value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedCategory = v ?? GalleryCategory.other),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: '备注（可选）',
                child: TextBox(
                  controller: remarkController,
                  placeholder: '请输入备注',
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _uploadImages(
                category: selectedCategory,
                remark: remarkController.text.trim(),
              );
            },
            child: const Text('选择文件'),
          ),
        ],
      ),
    );
  }
  Future<void> _uploadImages({String? category, String? remark}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      final provider = context.read<GalleryProvider>();
      int successCount = 0;
      for (final file in result.files) {
        if (file.path != null) {
          final success = await provider.uploadImage(
            file.path!,
            category: category,
            remark: remark,
          );
          if (success) successCount++;
        }
      }
      if (successCount > 0) {
        await FluentInfoBarHelper.showSuccess(context, '成功上传 $successCount 张图片');
      } else {
        await FluentInfoBarHelper.showError(context, '上传失败');
      }
    }
  }
  void _showImageDetail(GalleryImage image) {
    final screenSize = MediaQuery.of(context).size;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.95),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return material.Material(
          color: Colors.black,
          child: Stack(
            children: [
              Center(
                child: _buildAuthImage(image.url, fit: BoxFit.contain),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        Text(
                          image.name ?? '图片详情',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        if (image.category != null) ...[
                          const SizedBox(width: 16),
                          _buildInfoChipWhite('分类', GalleryCategory.labels[image.category] ?? image.category!),
                        ],
                        if (image.fileSize != null) ...[
                          const SizedBox(width: 16),
                          _buildInfoChipWhite('大小', _formatFileSize(image.fileSize!)),
                        ],
                        const Spacer(),
                        IconButton(
                          icon: const Icon(FluentIcons.copy, color: Colors.white),
                          onPressed: () {
                            if (image.url != null) {
                              Clipboard.setData(ClipboardData(text: image.url!));
                              FluentInfoBarHelper.showSuccess(ctx, '链接已复制');
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(FluentIcons.cancel, color: Colors.white),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        if (image.remark != null && image.remark!.isNotEmpty)
                          Text(
                            image.remark!,
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                          ),
                        if (image.url != null) ...[
                          const Spacer(),
                          Text(
                            image.url!.length > 60 ? '${image.url!.substring(0, 60)}...' : image.url!,
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildInfoChip(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: TextStyle(color: Colors.grey[100], fontSize: 12)),
        Text(value, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  Widget _buildInfoChipWhite(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }
  void _showEditDialog(GalleryImage image) {
    final nameController = TextEditingController(text: image.name);
    final remarkController = TextEditingController(text: image.remark);
    String category = image.category ?? GalleryCategory.other;
    showDialog(
      context: context,
      builder: (ctx) => ContentDialog(
        title: const Text('编辑图片'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLabel(
                label: '名称',
                child: TextBox(controller: nameController, placeholder: '图片名称'),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: '分类',
                child: StatefulBuilder(
                  builder: (context, setState) => ComboBox<String>(
                    value: category,
                    isExpanded: true,
                    items: GalleryCategory.labels.entries
                        .map((e) => ComboBoxItem(value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (v) => setState(() => category = v ?? GalleryCategory.other),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: '备注',
                child: TextBox(
                  controller: remarkController,
                  placeholder: '请输入备注',
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Button(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () async {
              final success = await context.read<GalleryProvider>().updateImage(
                    image.id,
                    UpdateGalleryRequest(
                      name: nameController.text.trim(),
                      category: category,
                      remark: remarkController.text.trim(),
                    ),
                  );
              Navigator.pop(ctx);
              if (success) {
                await FluentInfoBarHelper.showSuccess(context, '更新成功');
              } else {
                await FluentInfoBarHelper.showError(context, '更新失败');
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
  void _copyUrl(GalleryImage image) {
    if (image.url != null) {
      Clipboard.setData(ClipboardData(text: image.url!));
      FluentInfoBarHelper.showSuccess(context, '链接已复制');
    }
  }
  Future<void> _deleteImage(GalleryImage image) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这张图片吗？'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true) {
      final success = await context.read<GalleryProvider>().deleteImage(image.id);
      if (success) {
        await FluentInfoBarHelper.showSuccess(context, '删除成功');
      } else {
        await FluentInfoBarHelper.showError(context, '删除失败');
      }
    }
  }
  Future<void> _batchDelete() async {
    final provider = context.read<GalleryProvider>();
    final count = provider.selectedIds.length;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('确认批量删除'),
        content: Text('确定要删除选中的 $count 张图片吗？'),
        actions: [
          Button(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (result == true) {
      final success = await provider.batchDelete();
      if (success) {
        await FluentInfoBarHelper.showSuccess(context, '批量删除成功');
      } else {
        await FluentInfoBarHelper.showError(context, '批量删除失败');
      }
    }
  }
}
