part of 'models.dart';

/// Exception model for http related exceptions
class HttpException extends Equatable implements Exception {
  const HttpException([
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

  final String? _message;
  final String _prefix;

  String get message => _message ?? 'Something went wrong!';

  @override
  String toString() => '$_prefix$_message';

  @override
  List<Object?> get props => [_message, _prefix];
}

class NoDataException extends HttpException {
  const NoDataException([String prefix = ''])
      : super('Something went wrong, please try again later.', prefix);
}

class InternalServerException extends HttpException {
  const InternalServerException([String? message])
      : super(
          message ?? 'Unable to make a connection, please try again later.',
        );
}

class NoInternetException extends HttpException {
  const NoInternetException([
    super.message =
        'No internet access, please check your internet and try again.',
  ]);
}

class BadRequestException extends HttpException {
  const BadRequestException([String? message])
      : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends HttpException {
  const UnauthorisedException([String? message])
      : super(message, 'Unauthorised: ');
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
