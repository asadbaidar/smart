import 'dart:convert';

typedef MapObject = Map<dynamic, dynamic>;
typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension StringToJson on String {
  JsonObject? toJsonObject() {
    final dynamic value = jsonDecode(this);
    return value is JsonObject ? value : null;
  }

  JsonObject? get jsonObject => toJsonObject();

  JsonArray? toJsonArray() {
    final dynamic value = jsonDecode(this);
    return value is JsonArray ? value : null;
  }

  JsonArray? get jsonArray => toJsonArray();

  dynamic get json => jsonDecode(this);

  dynamic get jsonOrString {
    try {
      return jsonDecode(this);
    } catch (e) {
      return this;
    }
  }
}

extension JsonToString on Map<String, dynamic> {
  String toJsonString() => jsonEncode(this);

  String get jsonString => toJsonString();
}

extension JsonArrayToString on List<dynamic> {
  String toJsonString() => jsonEncode(this);

  String get jsonString => toJsonString();
}
