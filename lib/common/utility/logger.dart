import 'package:logger/logger.dart';

/// Wraps a [LogPrinter] and prepends the caller's file name and line number.
class _FileLocationPrinter extends LogPrinter {
  _FileLocationPrinter({required this.delegate, required this.callerFrameIndex});

  final LogPrinter delegate;
  final int callerFrameIndex;

  static final _frameRegex = RegExp(r'#[0-9]+\s+.+ \(([^)]+):([0-9]+):[0-9]+\)');

  String? _extractCallerLocation(StackTrace? stackTrace) {
    if (stackTrace == null) return null;
    final frames = stackTrace.toString().split('\n');
    if (callerFrameIndex >= frames.length) return null;
    final match = _frameRegex.firstMatch(frames[callerFrameIndex]);
    if (match == null) return null;
    final path = match.group(1)!;
    final line = match.group(2)!;
    final fileName = path.split(RegExp(r'[/\\]')).last;
    return '$fileName:$line';
  }

  @override
  List<String> log(LogEvent event) {
    final location = _extractCallerLocation(event.stackTrace);
    final prefix = location != null ? '[$location] ' : '';
    final wrappedEvent = LogEvent(
      event.level,
      prefix + event.message.toString(),
      time: event.time,
      error: event.error,
      stackTrace: event.stackTrace,
    );
    return delegate.log(wrappedEvent);
  }
}

class AppLogger {
  AppLogger._();
  static final AppLogger _instance = AppLogger._();
  static AppLogger get instance => _instance;

  /// Frame 0–2: Logger internals + AppLogger; 3: actual caller
  static const _callerFrameIndex = 3;

  final Logger _logger = Logger(
    printer: _FileLocationPrinter(
      delegate: PrettyPrinter(
        stackTraceBeginIndex: _callerFrameIndex,
        colors: false, // Disable ANSI color codes
        printEmojis: false, // Disable emojis
      ),
      callerFrameIndex: _callerFrameIndex,
    ),
  );

  void debug(String message) {
    _logger.d(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void error(String message) {
    _logger.e(message);
  }

  void fatal(String message, StackTrace? stackTrace) {
    _logger.f(message, stackTrace: stackTrace);
  }
}
