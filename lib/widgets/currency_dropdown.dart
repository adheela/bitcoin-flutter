import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CurrencyDropdown extends StatelessWidget {
  final List<String> currencies;
  final ValueNotifier notifier;
  String _selected;
  String get selected => _selected;

  CurrencyDropdown(this.currencies, this.notifier, this._selected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DropdownButton<String>(
    value: selected,
    items: currencies.map((currency) => DropdownMenuItem(
      child: Text(currency),
      value: currency,
    )).toList(),
    onChanged: (value) => notifier.value = _selected = value,
  );
}