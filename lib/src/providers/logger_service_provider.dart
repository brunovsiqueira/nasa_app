import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/src/services/implementations/logger_service_impl.dart';
import 'package:nasa_app/src/services/interfaces/logger_service.dart';

final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerServiceImpl();
});
