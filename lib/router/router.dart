import '../features/crypto_coin/crypto_coin.dart';
import '../features/crypto_list/view/crypto_list_screen.dart';

final routes = {
  '/': (context) => const CryptoListScreen(),
  '/coin': (context) => const CryptoCoinScreen()
};