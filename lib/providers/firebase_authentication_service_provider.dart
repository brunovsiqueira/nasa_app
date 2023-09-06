import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/services/implementations/firebase_authentication_service_impl.dart';
import 'package:nasa_app/services/interfaces/firebase_authentication_service.dart';

import 'logger_service_provider.dart';

final firebaseAuthenticationServiceProvider =
    Provider<FirebaseAuthenticationService>((ref) {
  return FirebaseAuthenticationServiceImpl(ref.read(loggerServiceProvider));
});
