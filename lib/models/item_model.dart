class ItemModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final String location;
  final String timeAgo;
  final String type;
  final String status;
  final String imageUrl;
  final String reportedBy;
  final String reportedByRole;
  final String recoveryLocation;
  final bool isSafeHandOff;
  final String contactEmail;

  String get image => imageUrl;

  const ItemModel({
    required this.id,
    this.userId = 'user1',
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.timeAgo,
    required this.type,
    this.status = 'Active',
    this.imageUrl = '',
    this.reportedBy = 'Campus Student',
    this.reportedByRole = 'Student',
    this.recoveryLocation = 'Campus Help Desk',
    this.isSafeHandOff = true,
    this.contactEmail = 'contact@campus.edu',
  });
}