import 'package:local_auth/local_auth.dart';

// Keeps the native authentication plugin behind an interface that tests can fake.
// ignore: one_member_abstracts
abstract interface class DeviceAuthenticator {
  Future<bool> authenticate(String reason);
}

class LocalDeviceAuthenticator implements DeviceAuthenticator {
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Future<bool> authenticate(String reason) => _auth.authenticate(
    localizedReason: reason,
  );
}
