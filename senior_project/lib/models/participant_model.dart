// Define Participant Model
class Participant {
  final String phone;
  final double totalExpense;
  final bool isLeader;
  final image;
  final String username; // Nullable field

  Participant(
      {required this.phone,
      required this.totalExpense,
      required this.isLeader,
      required this.image,      
      required this.username}); // Default value for userName

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      phone: json['phone'] ?? 'Unknown', // ✅ Provide default if null
      totalExpense: (json['totalExpense'] as num?)?.toDouble() ??
          0.0, // ✅ Ensure it's a double
      isLeader: json['isLeader'] ?? false, // ✅ Default to false if null
      image: json['image'] ?? null, // ✅ Provide default if null
      username: json['username'] ?? 'Unknown', // ✅ Provide default if null
    );
  }
}
