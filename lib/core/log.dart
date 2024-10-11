library utils;

import 'dart:developer' as logDev;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:logger/logger.dart';

class _ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(logDev.log);
  }
}

abstract class Log {
  static final _logger = Logger(
    output: _ConsoleOutput(),
    printer: PrettyPrinter(
      excludeBox: {
        // Level.trace: true,
        Level.debug: true,
        // Level.info: true,
        // Level.warning: true,
        // Level.fatal: false,
      },
      methodCount: 0,
      errorMethodCount: 15,
      lineLength: 120,
      noBoxingByDefault: true,
      colors: true,
      printEmojis: true,
    ),
  );

  static v(String str, {String? tag}) {
    _log(str, Level.verbose, tag: tag);
  }

  static d(String str, {String? tag}) {
    _log(str, Level.debug, tag: tag);
  }

  static i(String str, {String? tag}) {
    _log(str, Level.info, tag: tag);
  }

  static w(String str, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(str, Level.warning, tag: tag, error: error, stacktrace: stackTrace);
  }

  static e(String str, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(str, Level.error, tag: tag, error: error, stacktrace: stackTrace);
  }

  static tcp(String str, {String? tag}) {
    _log(str, Level.verbose, tag: tag);
  }

  static _log(String str, Level level, {String? tag, Object? error, StackTrace? stacktrace}) {
    if (tag != null && tag.isNotEmpty) tag = " [$tag]";
    String message = "[${DateTime.now()}]${tag ?? ''} $str";

    if (kReleaseMode) return;

    /// Deprecated - nothing(replace: off), wtf(replace: fatal), verbose(replace: trace)
    /// 아직 제거되지 않아 case를 명시해야 함으로, 우선 if문으로 대체
    if (level == Level.debug) {
      _logger.d(message);
      return;
    }

    if (level == Level.info) {
      _logger.i(message);
      return;
    }

    if (level == Level.warning) {
      _logger.w(message, error: error, stackTrace: stacktrace);
      return;
    }

    if (level == Level.error) {
      _logger.e(message, error: error, stackTrace: stacktrace);
      return;
    }

    if (level == Level.fatal) {
      _logger.f(message, error: error, stackTrace: stacktrace);
      return;
    }

    if (level == Level.trace) {
      _logger.t(message);
      return;
    }

    if (level == Level.off) {
      return;
    }

    if (level == Level.all) {
      return;
    }
  }
}
