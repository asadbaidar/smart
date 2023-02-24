part of 'utils.dart';

enum MapTravelMode {
  driving('d'),
  walking('w'),
  bicycling('b'),
  transit('r'),
  ;

  final String value;
  const MapTravelMode([this.value = '']);
}

enum MapPreference { google, apple, waze }

class MapNavigation extends Equatable {
  final MapLocation destination;
  final MapLocation? origin;
  final TargetPlatform? platform;
  final MapTravelMode travelMode;
  final MapPreference preference;

  const MapNavigation({
    required this.destination,
    this.origin,
    this.platform,
    this.travelMode = MapTravelMode.driving,
    this.preference = MapPreference.google,
  });

  MapNavigation copyWith({
    MapLocation? destination,
    MapLocation? origin,
    TargetPlatform? platform,
    MapTravelMode? travelMode,
    MapPreference? preference,
  }) {
    return MapNavigation(
      destination: destination ?? this.destination,
      origin: origin ?? this.origin,
      platform: platform ?? this.platform,
      travelMode: travelMode ?? this.travelMode,
      preference: preference ?? this.preference,
    );
  }

  String get googleUrl {
    final origin = this.origin?.latLngOrAddress ?? '';
    final destination = this.destination.latLngOrAddress ?? '';
    final travelMode = this.travelMode.name;
    return 'https://www.google.com/maps/dir/?api=1'
        '&origin=$origin'
        '&destination=$destination'
        '&travelmode=$travelMode';
  }

  String get appleUrl {
    final origin = this.origin?.address ?? '';
    final destination = this.destination.address ?? '';
    final travelMode = this.travelMode.value;
    return 'https://maps.apple.com/?'
        'saddr=$origin'
        '&daddr=$destination'
        '&dirflg=$travelMode';
  }

  String get wazeUrl {
    final destination = this.destination.latLng ?? '';
    return 'https://waze.com/ul?'
        'll=$destination'
        '&navigate=yes'
        '&zoom=17';
  }

  String get url {
    switch (preference) {
      case MapPreference.google:
        return googleUrl;
      case MapPreference.apple:
        return destination.hasAddress ? appleUrl : googleUrl;
      case MapPreference.waze:
        return destination.isNotEmpty ? wazeUrl : googleUrl;
    }
  }

  String get fallbackUrl {
    switch (preference) {
      case MapPreference.google:
        return destination.hasAddress ? appleUrl : wazeUrl;
      case MapPreference.apple:
        return googleUrl;
      case MapPreference.waze:
        switch (platform) {
          case TargetPlatform.android:
            return googleUrl;
          case TargetPlatform.iOS:
            return destination.hasAddress ? appleUrl : googleUrl;
          default:
            return googleUrl;
        }
    }
  }

  Future<bool> getDirections({
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      return await _launchUrl(url, mode);
    } catch (e) {
      return await _launchUrl(fallbackUrl, mode);
    }
  }

  Future<bool> _launchUrl(String url, LaunchMode mode) async {
    final uri = url.uri;
    if (uri == null) throw Exception('Invalid url: $url');
    final success = await launchUrl(uri, mode: mode);
    if (!success) throw Exception('Failed to launch map');
    return success;
  }

  @override
  List<Object?> get props => [
        destination,
        origin,
        platform,
        travelMode,
        preference,
      ];
}

class MapLocation extends Equatable {
  final double? latitude;
  final double? longitude;
  final String? address;

  const MapLocation({
    this.latitude,
    this.longitude,
    this.address,
  });

  bool get isEmpty => latitude == null || longitude == null;

  bool get isNotEmpty => !isEmpty;

  bool get hasAddress => address != null;

  String? get latLng => isNotEmpty ? '$latitude,$longitude' : null;

  String? get latLngOrAddress => latLng ?? address;

  MapLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return MapLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        address,
      ];
}
