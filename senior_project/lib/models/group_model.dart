class Group {
  final int id;
  final String name;
  final int budget;
  final String iconName; // Store icon as a URL

  Group({required this.id, required this.name, required this.budget, required this.iconName});

  // Factory method to create Group from JSON
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      budget: json['budget'], // Assuming the backend sends an icon URL
      iconName: json['iconName'], // Adjust this based on your backend response
    );
  }
}
