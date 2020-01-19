import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CurrencyPicker extends StatelessWidget {
  final List<String> currencies;
  final ValueNotifier notifier;
  String _selected;
  String get selected => _selected;

  CurrencyPicker(this.currencies, this.notifier, this._selected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPicker(
    scrollController: FixedExtentScrollController(initialItem: currencies.indexOf(_selected)),
    backgroundColor: Colors.lightBlue,
    itemExtent: 32.0,
    onSelectedItemChanged: (selectedIndex) =>
    notifier.value = _selected = currencies.elementAt(selectedIndex),
    children: currencies.map((currency) => Text(currency)).toList(),
  );
}
