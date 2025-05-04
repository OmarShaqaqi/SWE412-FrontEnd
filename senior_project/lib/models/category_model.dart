class Category {
  final int groupId;
  final String categoryName;
  final String iconName; // Store icon as a URL

  Category({
    required this.groupId,
    required this.categoryName,
    required this.iconName,
  });

  // Method to parse JSON data into a Category object
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      groupId: json['groupId'],
      categoryName: json['categoryName'],
      iconName: json['iconName']?? 'education', // Assuming the backend sends an icon URL
    );
  }
}