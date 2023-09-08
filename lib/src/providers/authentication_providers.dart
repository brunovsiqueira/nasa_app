import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/src/services/implementations/firebase_authentication_service_impl.dart';
import 'package:nasa_app/src/services/interfaces/authentication_service.dart';

import 'logger_service_provider.dart';

final firebaseAuthenticationServiceProvider =
    Provider<AuthenticationService>((ref) {
  return FirebaseAuthenticationServiceImpl(ref.read(loggerServiceProvider));
});

final signInFutureProvider = FutureProvider.autoDispose<bool>((ref) async {
  var result =
      await ref.read(firebaseAuthenticationServiceProvider).anonymousSignIn();
  bool success = false;
  result.fold((failure) {
    throw failure;
  }, (_) {
    success = true;
  });
  return success;
});
