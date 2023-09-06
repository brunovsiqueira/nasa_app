import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/providers/firebase_authentication_service_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();

    ref
        .read(firebaseAuthenticationServiceProvider)
        .anonymousSignIn(); //TODO: handle signin
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
