import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

List<Widget> getPickerItems() {
  List<Text> PickerItems = [];
  for (String currency in currenciesList) {
    PickerItems.add(Text(currency));
  }
  return PickerItems;
}

class IOSPicker extends StatefulWidget {
  @override
  State<IOSPicker> createState() => _IOSPickerState();
}

class _IOSPickerState extends State<IOSPicker> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 35.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: getPickerItems(),
    );
  }
}
