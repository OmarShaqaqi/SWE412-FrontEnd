import 'package:flutter/material.dart';
import 'package:senior_project/templates/custom_body_search.dart';
import 'package:senior_project/templates/custom_bottom_navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCategory = "All"; // Default category
  DateTime selectedDate = DateTime.now(); // Default date
  String reportType = "Expense"; // Default report type
  List<Map<String, dynamic>> results = []; // Filtered search results
  final List<Map<String, dynamic>> mockData = [
    {
      "category": "Food",
      "date": "2025-01-01",
      "title": "Dinner",
      "amount": -26.00
    },
    {
      "category": "Travel",
      "date": "2025-01-01",
      "title": "Bus Ticket",
      "amount": -10.00
    },
    {
      "category": "Salary",
      "date": "2025-01-01",
      "title": "Monthly Salary",
      "amount": -2000.00
    },
  ];
  @override
  void initState() {
    super.initState();
    _filterResults();
  }

  void _filterResults() {
    setState(() {
      results = mockData.where((item) {
        final categoryMatch =
            selectedCategory == "All" || item["category"] == selectedCategory;
        final dateMatch =
            item["date"] == selectedDate.toLocal().toString().split(" ")[0];
        return categoryMatch && dateMatch;
      }).toList();
    });
  }

  // Open date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _filterResults();
      });
    }
  }

  // Filter search results
  void _performSearch() {
    setState(() {
      results = mockData.where((item) {
        final categoryMatch =
            selectedCategory == "All" || item["category"] == selectedCategory;
        final dateMatch =
            item["date"] == selectedDate.toIso8601String().split("T")[0];
        final typeMatch =
            reportType == "Income" ? item["amount"] > 0 : item["amount"] < 0;

        return categoryMatch && dateMatch && typeMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Groups Label and Dropdown
        const Text(
          "Groups",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xff093030),
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedCategory,
          items: ["All", "Food", "Travel", "Salary"]
              .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value!;
              _filterResults();
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Date Label and Selector
        const Text(
          "Date",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xff093030),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  "${selectedDate.toLocal()}".split(" ")[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Search Results
        Expanded(
          child: results.isEmpty
              ? const Center(child: Text("No results found."))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          item["amount"] > 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        backgroundColor:
                            item["amount"] > 0 ? Colors.green : Colors.red,
                      ),
                      title: Text(item["title"]),
                      subtitle: Text("${item["date"]} - ${item["category"]}"),
                      trailing: Text(
                        "${item["amount"] > 0 ? "+" : ""}\$${item["amount"].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: item["amount"] > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Return to the previous page
          },
        ),
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00D09E), // Match app's color scheme
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xff00d09e), // Match app's color scheme
        child: CustomBodySearch(content: content),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
