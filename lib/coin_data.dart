import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinDataProvider {
  static const List<String> supportedCurrencies = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];

  static const String apikey = "558F2D45-2D93-49DA-955F-BB88A38F7B46";
  static const String coinURL = "https://rest.coinapi.io/v1/exchangerate/";

  Future<dynamic> getExchangeRate(String selectedCurrency, String crypto) async {
    NetworkHelper networkHelper = NetworkHelper(
      Uri.parse('$coinURL$crypto/$selectedCurrency/?apikey=$apikey'),
    );

    return networkHelper.getData();
  }
}

class NetworkHelper {
  NetworkHelper(this.url);
  final Uri url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
