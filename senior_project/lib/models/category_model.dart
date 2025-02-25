class Category {
  final int groupId;
  final String categoryName;

  Category({
    required this.groupId,
    required this.categoryName,
  });

  // Method to parse JSON data into a Category object
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      groupId: json['groupId'],
      categoryName: json['categoryName'],
    );
  }
}