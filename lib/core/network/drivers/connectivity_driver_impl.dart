import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_morthy_app/core/network/drivers/connectivity_driver.dart';

class ConnectivityDriverImpl implements ConnectivityDriver {
  @override
  Future<bool> isOnline() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }
}
