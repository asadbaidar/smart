part of 'models.dart';

/// Exception model for http related exceptions
class SmartHttpException implements Exception {
  final String? _message;
  final String _prefix;

  String get message => _message ?? "Something went wrong!";

  SmartHttpException([
    this._message,
    this._prefix = '',
  ]);

  SmartHttpException copyWith({
    String? message,
    String? prefix,
  }) {
    return SmartHttpException(
      message ?? _message,
      prefix ?? _prefix,
    );
  }

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class NoDataException extends SmartHttpException {
  NoDataException([String prefix = ''])
      : super('Something went wrong, please try again later.', prefix);
}

class InternalServerException extends SmartHttpException {
  InternalServerException([String? message])
      : super(
            message ?? 'Unable to make a connection, please try again later.');
}

class NoInternetException extends SmartHttpException {
  NoInternetException(
      [String message =
          'No internet access, please check your internet and try again.'])
      : super(message);
}

class BadRequestException extends SmartHttpException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends SmartHttpException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

class TimeoutException extends SmartHttpException {
  TimeoutException(
      [String message =
          'Its taking longer than usual, please check your internet and try again later.'])
      : super(message);
}

class CancelException extends SmartHttpException {
  CancelException([String message = 'Request Canceled']) : super(message);
}
