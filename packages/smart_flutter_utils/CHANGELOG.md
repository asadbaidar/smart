## [1.0.5]

* fix: fixed `BlocBase.when` method where it was ignoring the previous state changes in the next state emits.
* chore: Added simplified `LifecycleObserver` to observe the lifecycle of a widget including app lifecycle.

## [1.0.4]

* chore: bumped versions of dependencies.

## [1.0.3]

* feat: added `BuildContext.getPosition`, `BuildContext.getTextLines`, `BlocBase.when`
* refactor: changed all part files into standalone files for auto barrel generation

## [1.0.2]

* chore: added `validator` extensions
* chore: added `fromJson`, `toJson` in `Data` class to support serialization

## [1.0.1+3]

* chore: added `colorScheme` extensions on `BuildContext`

## [1.0.1+2]

* chore: exported cache files

## [1.0.1+1]

* chore: Formatted the code and updated dependencies

## [1.0.1]

* feat: Added validators:
    - `email.dart`
    - `file.dart`
    - `form_input.dart`
    - `password.dart`
    - `phone_number.dart`
    - `positive_int.dart`
    - `text_input.dart`
    - `validators.dart`
    - `verification_code.dart`

* feat: Added cache helpers:
    - `cache_storage.dart`
    - `cache.dart`
    - `cached_bloc.dart`
    - `secure_storage.dart`

* refactor: route utils

## [1.0.0+2]

* feat: Added `Data.when` extension method
Breaking Change:
* refactor: Renamed `DataState` to `Data`
* refactor: Renamed `DataStatus` to `DataState`

## [1.0.0+1]

* refactor: Restored mocks for testing

## [1.0.0]

* style: Applied strict lint rules
* refactor: Breaking Change: Renamed `ApiState` to `DataState`
* chore: Updated deprecated `backgroundColor` to `surfaceContainerColor`
* feat: Added new collection extensions: `whereNot`, `withoutBlanks`, `nonNullValues`, `nonBlankValues`, `nonBlankStringValues`, `removed`, `takeLast`, `skipLast`
* perf: Optimized Debouncer class to use Completer for handling Future completion
* feat: Added type casting mehods: `$castInt`, `$castBool`, `$castColor`
* feat: Add JSON utility methods
* refactor: Breaking Change: renamed and updated parameters of logger methods
* feat: Added number arithmetic extensions
* feat: Added `RouteUri` and extension methods for routing
* feat: Added `Snackbars` utility class for displaying snack bars
* feat: Added types.dart file with utility typedefs and callbacks
* feat: Added URL launcher utility methods

## [0.1.1]

* Fixed BorderRadius nullable error.

## [0.1.0]

* Flutter 3.7.0 fixes

## [0.0.9]

* Flutter 3.7.0 support

## [0.0.8]

* `PageInfo` bug fixes.

## [0.0.7]

* Added `PageInfo.start` parameter.

## [0.0.6]

* location utils fixes

## [0.0.5]

* added more collection utils

## [0.0.4]

* collection package dependency fixed.

## [0.0.3]

* Improved String concatenation and renamed as `prefix`, `suffix` and `confix`.
* Added `mapToList` method

## [0.0.2]

* Dart Format.

## [0.0.1]

* initial release.
