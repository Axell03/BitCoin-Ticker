import 'package:flutter/material.dart';
import 'coin_data.dart';

class CryptoPriceScreen extends StatefulWidget {
  @override
  _CryptoPriceScreenState createState() => _CryptoPriceScreenState();
}

class _CryptoPriceScreenState extends State<CryptoPriceScreen> {
  String selectedCurrency = 'USD';
  CoinDataProvider coinDataProvider = CoinDataProvider();

  String btcRate = 'NA';
  String ethRate = 'NA';
  String ltcRate = 'NA';

  @override
  void initState() {
    super.initState();
    updateRates(selectedCurrency);
  }

  Future<void> updateRates(String currency) async {
    String newBtcRate = 'NA';
    String newEthRate = 'NA';
    String newLtcRate = 'NA';

    var btcData = await coinDataProvider.getExchangeRate(currency, 'BTC');
    var ethData = await coinDataProvider.getExchangeRate(currency, 'ETH');
    var ltcData = await coinDataProvider.getExchangeRate(currency, 'LTC');

    if (btcData != null) {
      newBtcRate = btcData['rate'].toInt().toString();
    }

    if (ethData != null) {
      newEthRate = ethData['rate'].toInt().toString();
    }

    if (ltcData != null) {
      newLtcRate = ltcData['rate'].toInt().toString();
    }

    setState(() {
      btcRate = newBtcRate;
      ethRate = newEthRate;
      ltcRate = newLtcRate;
    });
  }

  DropdownButton<String> getCurrencyDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in CoinDataProvider.supportedCurrencies) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 20.0),
      onChanged: (String? value) {
        setState(() {
          selectedCurrency = value!;
          updateRates(selectedCurrency);
        });
      },
      items: dropdownItems,
      underline: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crypto Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                CryptoRateCard(
                  currency: selectedCurrency,
                  crypto: 'BTC',
                  rate: btcRate,
                ),
                SizedBox(height: 20.0),
                CryptoRateCard(
                  currency: selectedCurrency,
                  crypto: 'ETH',
                  rate: ethRate,
                ),
                SizedBox(height: 20.0),
                CryptoRateCard(
                  currency: selectedCurrency,
                  crypto: 'LTC',
                  rate: ltcRate,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getCurrencyDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoRateCard extends StatelessWidget {
  final String currency;
  final String crypto;
  final String rate;

  CryptoRateCard({required this.currency, required this.crypto, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          '1 $crypto = $rate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
