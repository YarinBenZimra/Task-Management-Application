import 'package:flutter/material.dart';

class RadioSelection extends StatefulWidget {
  final String titleName;
  final List<String> namesOfOptions;
  final void Function(String) onOptionSelected;
  RadioSelection({required this.onOptionSelected, required this.namesOfOptions, this.titleName= 'Priority:'});

  @override
  _RadioSelectionState createState() => _RadioSelectionState();
}

class _RadioSelectionState extends State<RadioSelection> {
  String selectedPriority = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleName,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...widget.namesOfOptions.map((String names) {
              return buildRadioButton(names);
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget buildRadioButton(String option) {
    return Row(
      children: [
        Radio(
          value: option,
          groupValue: selectedPriority,
          onChanged: (value) {
            setState(() {
              selectedPriority = value.toString();
            });
            widget.onOptionSelected(selectedPriority);
          },
        ),
        Text(option),
      ],
    );
  }
}