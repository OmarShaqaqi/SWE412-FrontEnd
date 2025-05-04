import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/widgets/price_widget.dart';
import 'package:senior_project/config.dart';

class CustomBodyGroup extends ConsumerStatefulWidget {
  final Widget content;

  const CustomBodyGroup({super.key, required this.content});

  @override
  ConsumerState<CustomBodyGroup> createState() => _CustomBodyGroupState();
}

class _CustomBodyGroupState extends ConsumerState<CustomBodyGroup> {
  double budget = 0;
  double expenses = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGroupData();
  }

  Future<void> _fetchGroupData() async {
    try {
      final token = ref.read(tokenProvider);
      final url = Uri.parse('$baseUrl/groups/personal');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          budget = (data['budget'] as num).toDouble();
          expenses = (data['expenses'] as num).toDouble();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load group data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double percentage = budget > 0 ? (expenses / budget).clamp(0, 1) : 0;

    return Column(
      children: [
        Container(
          height: screenHeight * 0.2,
          color: const Color.fromARGB(255, 0, 208, 158),
          child: isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Budget",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PriceWidget(price: budget),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Expenses",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PriceWidget(price: expenses),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 25,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 255, 243),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: percentage,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "${(percentage * 100).toStringAsFixed(0)}%",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${(percentage * 100).toStringAsFixed(0)}% of your expenses.",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: kBottomNavigationBarHeight,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 255, 243),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: widget.content,
          ),
        ),
      ],
    );
  }
}
