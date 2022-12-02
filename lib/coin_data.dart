import 'dart:convert';
import 'package:http/http.dart' as http;

final List<String> currenciesList = [
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

final List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL =
    'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=';
const apiKey =
    'e10666e2570b4925b35a8b9a2d105324a84cba332307064fe8fd20f524aeeece';

class CoinData {
  Future getData(String sc) async {
    String Url = '$coinAPIURL$sc&api_key=$apiKey';
    var url = Uri.parse(Url);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      double price = data['$sc'];
      return price.toStringAsFixed(0);
    } else {
      print(response.statusCode);
    }
  }
}
