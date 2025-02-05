import 'package:flutter/material.dart';

class CategroyuiHome extends StatefulWidget {
  const CategroyuiHome({super.key});

  @override
  State<CategroyuiHome> createState() => _CategroyuiHomeState();
}

class _CategroyuiHomeState extends State<CategroyuiHome> {
  bool selected = false;

  void _toggleSelected() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357,
      height: 41,
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(left: 20.0, right: 20.0)),
            backgroundColor: MaterialStateProperty.all(selected
                ? Color.fromRGBO(0, 255, 194, 1)
                : Color.fromRGBO(186, 238, 225, 1)),
          ),
          onPressed: () {
            _toggleSelected();
          },
          child: Align(alignment: Alignment.centerLeft, child: Text("food"))),
    );
  }
}
