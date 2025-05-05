import 'package:flutter/material.dart';
import "../screens/profile/profile.dart";
import "../screens/groups/groups.dart";
import "../screens/home/HomeScreen.dart";
import "../screens/analyst/analysis.dart";
import "../screens/analyst/search_page.dart";
import "../screens/transactions/transaction_page.dart";

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
  @override
  int _currentIndex = 0; // Tracks the selected index

  // List of screens corresponding to each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const AnalysisPage(),
    //const SearchPage(),
    const TransactionPage(),
    const GroupsScreen(),
    ProfileScreen(),    
  ];

  // Function to navigate to the selected screen
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update selected index
    });
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 223, 247, 226),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: BottomNavigationBar(
            onTap: _onItemTapped,
            backgroundColor: const Color.fromARGB(255, 223, 247, 226),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 0, 208, 158),
            items: const [
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.center,
                  child: ImageIcon(
                    AssetImage("assets/Home.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.center,
                  child: ImageIcon(
                    AssetImage("assets/Analysis.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.center,
                  child: ImageIcon(
                    AssetImage("assets/Transactions.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.center,
                  child: ImageIcon(
                    AssetImage("assets/Category.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Align(
                  alignment: Alignment.center,
                  child: ImageIcon(
                    AssetImage("assets/Profile.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}