## [1.0.4]

* chore: bumped versions of dependencies.
* fix: removed `dart:io` dependency to make it compatible with web.

## [1.0.3]

* chore: made `HttpClient.mapError` public.
* chore: added `HttpException.code` to set http status codes.
* fix: used the original http error message when passing to `HttpException` instead of a default message

## [1.0.2]

* chore: made `HttpClient.decodeErrorData` public.
* chore: moved `CancelableBlocMixin.tryIt` to extension method.
* chore: made `HttpClientConfig` equatable.
* fix: handled type casting issue in `HttpClient.decodeData` which will throw a `TypeMismatchException` with the data that was unable to cast.

## [1.0.1]

* chore: made `decodeErrorMessage` public.

## [1.0.0+3]

* chore: updated dependencies.

## [1.0.0+2]

* chore: made `HttpClient.successCodes` public.

## [1.0.0+1]

* refactor: Hide private extension methods. 

## [1.0.0]

* Initial stable release.

## [0.0.3]

* Updated dependencies.

## [0.0.2]

* Added example.

## [0.0.1]

* initial release.
