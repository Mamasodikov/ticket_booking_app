import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    final support = await _auth.isDeviceSupported();
    if (!isAvailable) return false;
    if (!support) return false;
    try {
      return await _auth.authenticate(
          options: AuthenticationOptions(biometricOnly: true),
          localizedReason: '\n${scannerToContinue}');
    } catch (e) {
      return false;
    }
  }
}
