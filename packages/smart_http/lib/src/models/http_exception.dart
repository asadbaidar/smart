part of 'models.dart';

/// Exception model for http related exceptions
class HttpException extends Equatable implements Exception {
  const HttpException([
    this._message,
    this._prefix = '',
    this._code = 0,
    this._data,
  ]);

  HttpException copyWith({
    String? message,
    String? prefix,
    int? code,
    dynamic data,
  }) {
    return HttpException(
      message ?? _message,
      prefix ?? _prefix,
      code ?? _code,
      data ?? _data,
    );
  }

  final String? _message;
  final String _prefix;
  final int _code;
  final dynamic _data;

  String get message => _message ?? 'Something went wrong!';

  int get code => _code;

  dynamic get data => _data;

  @override
  String toString() => '$_prefix$_message';

  @override
  List<Object?> get props => [_message, _prefix, _code, _data];
}

class NotFoundException extends HttpException {
  const NotFoundException([String? message])
      : super(message ?? 'Resource not found.', '', 404);
}

class NoDataException extends HttpException {
  const NoDataException(int code, [String? message])
      : super(message ?? 'Something went wrong, please try again later.', '',
            code);
}

class TypeMismatchException extends HttpException {
  TypeMismatchException([dynamic data])
      : super(data?.toString() ?? 'Type used is not matching the expected one.',
            '', 200, data);
}

class InternalServerException extends HttpException {
  const InternalServerException([String? message])
      : super(message ?? 'Unable to make a connection, please try again later.',
            '', 500);
}

class NoInternetException extends HttpException {
  const NoInternetException([
    super.message =
        'No internet access, please check your internet and try again.',
  ]);
}

class BadRequestException extends HttpException {
  const BadRequestException([String? message])
      : super(message, 'Invalid Request: ', 400);
}

class UnauthorisedException extends HttpException {
  const UnauthorisedException(int code, [String? message])
      : super(message, 'Unauthorised: ', code);
}

class TimeoutException extends HttpException {
  const TimeoutException([
    super.message =
        'Its taking longer than usual, please check your internet and try again later.',
  ]);
}

class CancelException extends HttpException {
  const CancelException([super.message = 'Request Canceled']);
}
