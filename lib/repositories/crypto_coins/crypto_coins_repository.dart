import 'package:currency/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({required this.dio});
  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DOT,BNB,XRP,ADA,SOL,AVAX&tsyms=USD',
    );

    final Map<String, dynamic> data = response.data;
    final Map<String, dynamic> dataRaw = data['RAW'];

    final cryptoCoinsList = dataRaw.entries.map((e) {
      final Map<String, dynamic> usdData = e.value['USD'];

      return CryptoCoin(
        name: e.key,
        priceInUSD: usdData['PRICE'],
        imageUrl: 'https://www.cryptocompare.com/${usdData['IMAGEURL']}',
      );
    }).toList();

    return cryptoCoinsList;
  }
}
