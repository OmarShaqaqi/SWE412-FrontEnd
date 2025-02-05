import 'package:flutter/material.dart';
import 'package:senior_project/screens/home/categroyUI_home.dart';
import "../../templates/custom_bottom_navigation_bar.dart";

class GroupsUiHome extends StatelessWidget {
  const GroupsUiHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 398,
          height: 51,
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(175, 201, 195, 1),
            borderRadius: BorderRadius.circular(41.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "personal",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const IconButtonWithState(),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 10,
        )
      ],
    );
  }
}

class IconButtonWithState extends StatefulWidget {
  const IconButtonWithState({super.key});

  @override
  _IconButtonWithStateState createState() => _IconButtonWithStateState();
}

class _IconButtonWithStateState extends State<IconButtonWithState> {
  bool _isIconChanged = true;

  void _toggleIcon() {
    setState(() {
      _isIconChanged = !_isIconChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
          padding: EdgeInsets.all(0),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 0, 0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
          icon: _isIconChanged
              ? const Icon(Icons.keyboard_arrow_down)
              : const Icon(Icons.close),
          iconSize: 16,
          onPressed: _toggleIcon,
        ),
      ),
    );
  }
}
