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

  ItemModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    String? location,
    String? timeAgo,
    String? type,
    String? status,
    String? imageUrl,
    String? reportedBy,
    String? reportedByRole,
    String? recoveryLocation,
    bool? isSafeHandOff,
    String? contactEmail,
  }) {
    return ItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      timeAgo: timeAgo ?? this.timeAgo,
      type: type ?? this.type,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedByRole: reportedByRole ?? this.reportedByRole,
      recoveryLocation: recoveryLocation ?? this.recoveryLocation,
      isSafeHandOff: isSafeHandOff ?? this.isSafeHandOff,
      contactEmail: contactEmail ?? this.contactEmail,
    );
  }
}