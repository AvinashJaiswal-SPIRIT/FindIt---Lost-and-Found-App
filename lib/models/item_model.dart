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

  // Create an updated copy of this item
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

  // Convert item model to map for Cloud Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'location': location,
      'timeAgo': timeAgo,
      'type': type,
      'status': status,
      'imageUrl': imageUrl,
      'reportedBy': reportedBy,
      'reportedByRole': reportedByRole,
      'recoveryLocation': recoveryLocation,
      'isSafeHandOff': isSafeHandOff,
      'contactEmail': contactEmail,
    };
  }

  // Construct item model from Cloud Firestore document map
  factory ItemModel.fromMap(Map<String, dynamic> map, [String? docId]) {
    return ItemModel(
      id: docId ?? map['id']?.toString() ?? '',
      userId: map['userId']?.toString() ?? 'user1',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? 'Other',
      location: map['location']?.toString() ?? '',
      timeAgo: map['timeAgo']?.toString() ?? 'Recently',
      type: map['type']?.toString() ?? 'Found',
      status: map['status']?.toString() ?? 'Active',
      imageUrl: map['imageUrl']?.toString() ?? '',
      reportedBy: map['reportedBy']?.toString() ?? 'Campus Member',
      reportedByRole: map['reportedByRole']?.toString() ?? 'Student',
      recoveryLocation: map['recoveryLocation']?.toString() ?? 'Campus Help Desk',
      isSafeHandOff: map['isSafeHandOff'] == true,
      contactEmail: map['contactEmail']?.toString() ?? 'contact@campus.edu',
    );
  }
}