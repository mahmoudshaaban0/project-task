import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({required this.connectivityChecker});
  final InternetConnectionChecker connectivityChecker;

  @override
  Future<bool> get isConnected async {
    try {
      // Configure the checker with custom settings for better reliability
      final checker =
          InternetConnectionChecker.createInstance(
              checkInterval: const Duration(seconds: 1),
            )
            // Add your API server as a custom address to check
            ..addresses = [
              AddressCheckOption(
                uri: Uri.parse('8.8.8.8'),
              ),
              AddressCheckOption(
                uri: Uri.parse('1.1.1.1'),
              ),
            ];

      return await checker.hasConnection;
    } on Exception catch (e) {
      log(e.toString());
      return connectivityChecker.hasConnection;
    }
  }
}
