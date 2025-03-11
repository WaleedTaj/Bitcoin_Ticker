import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'EUR',
  'GBP',
  'HKD',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const apiKey = 'Your_API_Key';
const coinAPIURL = 'https://api-realtime.exrates.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      final String url = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double currencyRate = decodedData['rate'];
        cryptoPrices[crypto] = currencyRate.toStringAsFixed(0);
      } else {
        print('Error: ${response.statusCode}');
        throw 'Failed to fetch data';
      }
    }
    print('$selectedCurrency: $cryptoPrices');
    return cryptoPrices;
  }
}
