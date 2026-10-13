import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';
import '../widgets/app_header.dart';
import '../widgets/auto_save_header.dart';
import '../widgets/deed_banner.dart';
import '../widgets/item_type_selector.dart';
import '../widgets/photo_upload_box.dart';
import '../widgets/primary_button.dart';
import '../widgets/safe_handoff_tile.dart';

class ReportItemScreen extends StatefulWidget {
  const ReportItemScreen({super.key});

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

  final List<String> _categories = [
    'Electronics & Audio',
    'ID & Cards',
    'Bikes & Keys',
    'Clothing & Bags',
    'Books & Notes',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = ItemModel(
        id: 'FD-${DateTime.now().millisecondsSinceEpoch % 10000}',
        title: _titleController.text,
        description: _descController.text,
        category: _category,
        location: _locationController.text,
        timeAgo: 'Just now',
        type: _itemType,
        imageUrl: 'assets/images/report_image.jpg',
        reportedBy: 'Alex Rivers',
        reportedByRole: 'Senior • Engineering',
        recoveryLocation: 'Student Union Room 104',
        isSafeHandOff: _safeHandOff,
      );
      sampleItems.insert(0, newItem);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item reported successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Report Item', showBack: true),
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
              text: 'Submit Report',
              icon: Icons.play_arrow_rounded,
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
        const SizedBox(height: 8),
        PhotoUploadBox(onCameraTap: () {}, onGalleryTap: () {}),
      ],
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Item Title *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text('${_titleController.text.length} / 60', style: const TextStyle(fontSize: 10, color: AppColors.muted)),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _titleController,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'e.g. Sony WH-1000XM4 Headphones',
            helperText: 'Give a concise name including brand or model',
            helperStyle: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Campus Location / Building *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text('📍 Quad 2', style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _locationController,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'e.g. Student Union Lounge, 1st Floor',
            prefixIcon: Icon(Icons.location_on_outlined, size: 18, color: AppColors.muted),
            helperText: 'Specify room number, lounge corner, or nearby landmark',
            helperStyle: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date & Estimated Time *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _dateController,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'e.g. Today, May 14 • 11:30 AM',
            prefixIcon: Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.muted),
            suffixIcon: Icon(Icons.access_time_rounded, size: 16, color: AppColors.muted),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detailed Description', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _descController,
          maxLines: 3,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'Describe condition, distinguishing marks, stickers...',
            helperText: 'Tip: Keep a small hidden detail private to verify the true owner!',
            helperStyle: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}