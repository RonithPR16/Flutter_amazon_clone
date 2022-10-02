import 'package:local_auth/local_auth.dart';

Future<bool> authenticate() async {
  print("Called authenication");
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool isBiometricSupported = await localAuthentication.isDeviceSupported();
  print(isBiometricSupported);
  bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
  print(canCheckBiometrics);
  List<BiometricType> biometricTypes =
      await localAuthentication.getAvailableBiometrics();
  print(biometricTypes);
  bool isAuthenticated = false;
  if (isBiometricSupported && canCheckBiometrics) {
    isAuthenticated = await localAuthentication.authenticate(
        options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
        localizedReason: "Please authenticate using fingerprint");
  }
  return isAuthenticated;
}
