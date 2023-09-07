import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nasa_app/src/network/implementations/api_impl.dart';
import 'package:nasa_app/src/network/interfaces/api.dart';
import 'package:nasa_app/src/providers/logger_service_provider.dart';
import 'package:nasa_app/src/services/implementations/connectivity_service_impl.dart';

final apiProvider = Provider<API>((ref) {
  return APIImpl(
    headersBuilders: {},
    dio: Dio(),
    connectivityService: ConnectivityServiceImpl(
      ref.read(loggerServiceProvider),
      InternetConnection(),
    ),
  );
});
