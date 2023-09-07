import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/errors/failures/base_failure.dart';
import 'package:nasa_app/providers/authentication_providers.dart';
import 'package:nasa_app/routes.dart';
import 'package:nasa_app/widgets/error_widget.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<bool> asyncResponse = ref.watch(signInFutureProvider);
    return Scaffold(
      body: asyncResponse.when(
        data: (_) {
          Navigator.of(context).pushNamed(Routes.roversHome);
          return Container();
        },
        error: (error, _) {
          return FailureWidget(
            failure: error as BaseFailure,
            refreshCallback: () {
              ref.invalidate(signInFutureProvider);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
