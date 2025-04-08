class Expense {
  final int id;
  final DateTime date; // ✅ Convert date from String to DateTime
  final double amount;
  final String status; // ✅ Status is String (PENDING, APPROVED, REJECTED)
  final String categoryName;

  Expense({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.categoryName,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: (json['id'] != null) ? (json['id'] as int) : 0, // ✅ Handle null id
      date: DateTime.parse(json['date']), // ✅ Convert from String to DateTime
      amount: (json['amount'] as num).toDouble(),
      status: (json['status'] != null) ? (json['status'] as String) : "no", // ✅ Keep status as String
      categoryName: json['categoryName'] as String,
    );
  }

  // ✅ Helper method to check if expense is pending
  bool get isPending => status.toUpperCase() == "PENDING";
}
