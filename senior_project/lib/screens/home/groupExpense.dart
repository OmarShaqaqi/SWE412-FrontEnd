import 'package:flutter/material.dart';
import 'package:senior_project/data/groups_data.dart';
import 'package:senior_project/screens/home/categorization.dart';
import 'package:senior_project/screens/profile/profile_edit.dart';
import "../../templates/custom_bottom_navigation_bar.dart";

class Groupexpense extends StatelessWidget {
  const Groupexpense({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
 // Add your functionality here
  },
      child: Column(
        children: [
          Container(
              width:
                  double.infinity, // Make the container take up 100% of the width
              height: 89, // Set the height of the container
              // color: const Color.fromRGBO(88, 204, 176, 1), // Light green background
              padding: const EdgeInsets.only(
                left: 20.0, // Add left padding
                right: 20.0, // Add right padding
                bottom: 10.0, // Add bottom padding
                top: 5, // Add top padding
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(88, 204, 176, 1), // maybe delleted :(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GroupIcon(),
                  // ignore: prefer_const_constructors
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Participant 1",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        " 500 SAR",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Text("Food"),
                  Row(
                    
                    children: [
                      ElevatedButton.icon(onPressed: (){}, 
                                          label: Icon(Icons.check_circle_outline_sharp),
                                          ),
                      
                      ElevatedButton.icon(onPressed: (){}, 
                                          label: Icon(Icons.cancel_sharp),
                                          )
                    ],
                  )
                ],
              )
            ),
          SizedBox(
            width: double.infinity,
            height: 10,
          )
        ],
      ),
    );
  }

  Container GroupIcon() {
    return Container(
      height: double.infinity,
      // decoration: const BoxDecoration(
      //   color: Color.fromRGBO(0, 104, 255, 1),
      // ),
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            child: Align(              
              alignment: Alignment.center,
              child: Container(
                height: 55,
                child: groups[0].icon,
              ),
            ),
          ),
                    Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Family",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}