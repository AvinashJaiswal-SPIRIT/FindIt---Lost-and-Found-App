import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../services/firestore_service.dart';
import '../widgets/app_header.dart';
import '../widgets/auto_save_header.dart';
import '../widgets/deed_banner.dart';
import '../widgets/item_type_selector.dart';
import '../widgets/photo_upload_box.dart';
import '../widgets/primary_button.dart';
import '../widgets/report_text_field.dart';
import '../widgets/safe_handoff_tile.dart';

class ReportItemScreen extends StatefulWidget {
  final ItemModel? itemToEdit;
  const ReportItemScreen({super.key, this.itemToEdit});

  @override
  State<ReportItemScreen> createState() => _ReportItemScreenState();
}

class _ReportItemScreenState extends State<ReportItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _itemType = 'Found';
  final _titleController = TextEditingController();
  String _category = 'Electronics & Audio';
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _descController = TextEditingController();
  bool _safeHandOff = false;
  String? _selectedImagePath;

  final List<String> _categories = [
    'Electronics & Audio',
    'ID & Cards',
    'Bikes & Keys',
    'Clothing & Bags',
    'Books & Notes',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.itemToEdit != null) {
      final item = widget.itemToEdit!;
      _titleController.text = item.title;
      _locationController.text = item.location;
      _descController.text = item.description;
      _category = _categories.contains(item.category) ? item.category : _categories.first;
      _itemType = item.type;
      _safeHandOff = item.isSafeHandOff;
      if (item.imageUrl.isNotEmpty) {
        _selectedImagePath = item.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source);
      if (picked != null) {
        setState(() => _selectedImagePath = picked.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            content: Text('Could not access image: $e'),
          ),
        );
      }
    }
  }

  void _submitReport() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final resolvedImageUrl = (_selectedImagePath != null && _selectedImagePath!.isNotEmpty)
        ? _selectedImagePath!
        : 'assets/images/report_image.jpg';

    if (widget.itemToEdit != null) {
      final updated = widget.itemToEdit!.copyWith(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        category: _category,
        location: _locationController.text.trim(),
        type: _itemType,
        isSafeHandOff: _safeHandOff,
        imageUrl: resolvedImageUrl,
      );
      FirestoreService.updateItem(updated);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: Duration(seconds: 4), content: Text('Item updated successfully!')),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      final newItem = ItemModel(
        id: 'FD-${DateTime.now().millisecondsSinceEpoch % 10000}',
        userId: user?.uid ?? 'user1',
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        category: _category,
        location: _locationController.text.trim(),
        timeAgo: 'Just now',
        type: _itemType,
        imageUrl: resolvedImageUrl,
        reportedBy: user?.displayName ?? user?.email?.split('@')[0] ?? 'Alex Rivers',
        reportedByRole: 'Campus Member',
        recoveryLocation: 'Student Union Room 104',
        isSafeHandOff: _safeHandOff,
        contactEmail: user?.email ?? 'contact@campus.edu',
      );
      FirestoreService.addItem(newItem);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: Duration(seconds: 4), content: Text('Item reported successfully!')),
      );
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: widget.itemToEdit != null ? 'Edit Listing' : 'Report Item',
        showBack: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            const AutoSaveHeader(),
            const SizedBox(height: 12),
            ItemTypeSelector(
              selectedType: _itemType,
              onChanged: (type) => setState(() => _itemType = type),
            ),
            const SizedBox(height: 14),
            const DeedBanner(),
            const SizedBox(height: 16),
            _buildPhotoSection(),
            const SizedBox(height: 16),
            _buildTitleField(),
            const SizedBox(height: 14),
            _buildCategoryDropdown(),
            const SizedBox(height: 14),
            _buildLocationField(),
            const SizedBox(height: 14),
            _buildDateField(),
            const SizedBox(height: 14),
            _buildDescriptionField(),
            const SizedBox(height: 14),
            SafeHandoffTile(
              value: _safeHandOff,
              onChanged: (v) => setState(() => _safeHandOff = v),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: widget.itemToEdit != null ? 'Save Changes' : 'Submit Report',
              icon: Icons.check_circle_outline,
              onPressed: _submitReport,
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Save as Draft',
                  style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Item Photos *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.text)),
            Text('🌟 Recommended', style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        PhotoUploadBox(
          selectedImagePath: _selectedImagePath,
          onCameraTap: () => _pickImage(ImageSource.camera),
          onGalleryTap: () => _pickImage(ImageSource.gallery),
          onRemoveTap: () => setState(() => _selectedImagePath = null),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return ReportTextField(
      label: 'Item Title *',
      hint: 'e.g. Sony WH-1000XM4 Headphones',
      helperText: 'Give a concise name including brand or model',
      controller: _titleController,
      onChanged: (_) => setState(() {}),
      trailing: Text(
        '${_titleController.text.length} / 60',
        style: const TextStyle(fontSize: 10, color: AppColors.muted),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _category,
          style: const TextStyle(fontSize: 13, color: AppColors.text),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.headphones_outlined, size: 18, color: AppColors.muted),
          ),
          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => setState(() => _category = v ?? _category),
        ),
      ],
    );
  }

  Widget _buildLocationField() {
    return ReportTextField(
      label: 'Campus Location / Building *',
      hint: 'e.g. Student Union Lounge, 1st Floor',
      helperText: 'Specify room number, lounge corner, or nearby landmark',
      prefixIcon: Icons.location_on_outlined,
      controller: _locationController,
      trailing: const Text(
        '📍 Quad 2',
        style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDateField() {
    return ReportTextField(
      label: 'Date & Estimated Time *',
      hint: 'e.g. Today, May 14 • 11:30 AM',
      prefixIcon: Icons.calendar_today_outlined,
      controller: _dateController,
    );
  }

  Widget _buildDescriptionField() {
    return ReportTextField(
      label: 'Detailed Description',
      hint: 'Describe condition, distinguishing marks, stickers...',
      helperText: 'Tip: Keep a small hidden detail private to verify the true owner!',
      controller: _descController,
      maxLines: 3,
    );
  }
}