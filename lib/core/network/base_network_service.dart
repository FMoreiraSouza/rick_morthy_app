import 'package:rick_morthy_app/core/network/drivers/connectivity_driver.dart';
import 'package:rick_morthy_app/core/network/failure.dart';

abstract class BaseNetworkService {
  final ConnectivityDriver connectivityDriver;

  BaseNetworkService({required this.connectivityDriver});

  Future<void> isConnected() async {
    final isOnline = await connectivityDriver.isOnline();
    if (!isOnline) {
      throw const ConnectionFailure();
    }
  }
}
