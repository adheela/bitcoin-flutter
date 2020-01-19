import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coins.dart' as coins;
import 'widgets/crypto_card.dart';
import 'widgets/currency_dropdown.dart';
import 'widgets/currency_picker.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = coins.currencies.first;

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  final valueNotifier = ValueNotifier<String>(null);

  void getData() async {
    isWaiting = true;
    try {
      var data = await coins.getCoinData(selectedCurrency);
      if (!mounted) return;
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    valueNotifier.addListener(() {
      selectedCurrency = valueNotifier.value;
      setState(getData);
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

  Widget getCards() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: coins.cryptos.map((crypto) =>
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto],
        )
    ).toList(growable: false),
  );

  Widget getPicker() =>
      Theme.of(context).platform == TargetPlatform.iOS
      ? CurrencyPicker(coins.currencies, valueNotifier, selectedCurrency)
      : CurrencyDropdown(coins.currencies, valueNotifier, selectedCurrency);

}
