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
    'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC&tsyms=';
const apiKey = ''; //use your own api key

class CoinData {
  Future getData(String sc, String coin) async {
    // ignore: non_constant_identifier_names
    String Url = '$coinAPIURL$sc&api_key=$apiKey';
    var url = Uri.parse(Url);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // ignore: unnecessary_string_interpolations
      double BTCprice = data['BTC']['$sc'];
      double ETHprice = data['ETH']['$sc'];
      double LTCprice = data['LTC']['$sc'];

      if (coin == 'BTC') {
        return BTCprice.toStringAsFixed(0);
      } else if (coin == 'ETH') {
        return ETHprice.toStringAsFixed(0);
      } else if (coin == 'LTC') {
        return LTCprice.toStringAsFixed(0);
      }
    } else {
      print(response.statusCode);
    }
  }
}
