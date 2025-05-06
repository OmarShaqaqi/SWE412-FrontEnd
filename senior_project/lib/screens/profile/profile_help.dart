import 'package:flutter/material.dart';
import "package:senior_project/templates/custom_scaffold.dart";
import "../../templates/custom_bottom_navigation_bar.dart";
import "../../widgets/faq_list.dart";
import "../../widgets/contact_us.dart";
import "../../templates/custom_body.dart";

class ProfileHelpScreen extends StatefulWidget {

  const ProfileHelpScreen({super.key});
  @override
  State<ProfileHelpScreen> createState() => _ProfileHelpScreen();
}

class _ProfileHelpScreen extends State<ProfileHelpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Two tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final content = Column(
          children: [
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 247, 226),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 208, 158),
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(255, 9, 48, 48),
                tabs: const [
                  Tab(
                    child: SizedBox(
                      height: 20,
                      width: 150,
                      child: Center(child: Text("FAQ")),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      height: 20,
                      width: 150,
                      child: Center(child: Text("Contact Us")),
                    ),
                  ),
                  
                ],
                indicatorColor: const Color.fromARGB(255, 0, 208, 158),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FaqList(),
                  ContactUs(),
                ],
              ),
            )
          ],
        );

        return CustomScaffold(title: "FAQs", content: CustomBody(content: content,),);
  }
}
