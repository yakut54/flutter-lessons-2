import 'package:currency/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository extends AbstractCoinsRepository {
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DOT,BNB,XRP,ADA,SOL,AVAX&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries
        .map((e) {
          final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = 'https://www.cryptocompare.com/${usdData['IMAGEURL']}';

          return CryptoCoin(
              name: e.key,
              priceInUSD: price,
              imageUrl: imageUrl,
          );
        }).toList();

    return cryptoCoinsList;
  }
}
