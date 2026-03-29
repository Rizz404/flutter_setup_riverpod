import 'package:flutter_setup_riverpod/core/utils/logger.dart';

extension LoggerExtensions on Object {
  String get _className => runtimeType.toString();

  void logInfo(String message) {
    logger.info('[$_className] $message');
  }

  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    logger.error('[$_className] $message', error, stackTrace);
  }

  void logData(String message, [Object? error, StackTrace? stackTrace]) {
    logger.logData(
      '[$_className] $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logDomain(String message, [Object? error, StackTrace? stackTrace]) {
    logger.logDomain(
      '[$_className] $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logPresentation(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    logger.logPresentation(
      '[$_className] $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void logService(String message, [Object? error, StackTrace? stackTrace]) {
    logger.logService(
      '[$_className] $message',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
