class Group {
  final int id;
  final String name;
  final int budget; // Store icon as a URL

  Group({required this.id, required this.name, required this.budget});

  // Factory method to create Group from JSON
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      budget: json['budget'], // Assuming the backend sends an icon URL
    );
  }
}
