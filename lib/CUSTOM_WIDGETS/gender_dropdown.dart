import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({Key? key, this.callback, this.dropdownValue}) : super(key: key);

  final void Function(String)? callback;
  final String? dropdownValue;

  @override
  _GenderDropdownState createState() => _GenderDropdownState(
      callback: callback,
      dropdownValue: dropdownValue
  );
}

class _GenderDropdownState extends State<GenderDropdown> {
  _GenderDropdownState({this.callback, this.dropdownValue});

  String? dropdownValue;
  final void Function(String)? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment:  Alignment.center,
      width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.3),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButton<dynamic>(
          borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          value: dropdownValue ?? 'Male',
          items: ['Male', 'Female','Other',].map((String? item) {
            return DropdownMenuItem(
                value: item!,
                child: Text(item, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),)
            );
          }).toList(),
          onChanged: (v) {
            setState(() {
              dropdownValue = v!;
              callback!(v);
            });
          },
          underline: Container(),
        )
      )
    );
  }
}