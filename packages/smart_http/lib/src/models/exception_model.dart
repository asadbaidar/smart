part of 'models.dart';

/// Exception model for http related exceptions
class HttpException implements Exception {
  final String? _message;
  final String _prefix;

  String get message => _message ?? "Something went wrong!";

  HttpException([
    this._message,
    this._prefix = '',
  ]);

  HttpException copyWith({
    String? message,
    String? prefix,
  }) {
    return HttpException(
      message ?? _message,
      prefix ?? _prefix,
    );
  }

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class NoDataException extends HttpException {
  NoDataException([String prefix = ''])
      : super('Something went wrong, please try again later.', prefix);
}

class InternalServerException extends HttpException {
  InternalServerException(
      [String message = 'Unable to make a connection, please try again later.'])
      : super(message);
}

class NoInternetException extends HttpException {
  NoInternetException(
      [String message =
          'No internet access, please check your internet and try again.'])
      : super(message);
}

class BadRequestException extends HttpException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

class TimeoutException extends HttpException {
  TimeoutException(
      [String message =
          'Its taking longer than usual, please check your internet and try again later.'])
      : super(message);
}

class CancelException extends HttpException {
  CancelException([String message = 'Request Canceled']) : super(message);
}
