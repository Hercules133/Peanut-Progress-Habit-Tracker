import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'storage_service.dart';

class FCloudStorage implements StorageService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<void> save(
      String table,
      Map<String, dynamic> data,
      String Function(Map<String, dynamic>) keySelector,
      ) async {
    final key = normalizeKey(keySelector(data));
    final DatabaseReference ref = _database.ref('$table/$key');
    final normalizedData = normalizeDataKeys(data);

    final snapshot = await ref.get();
    if (snapshot.exists) {
      await ref.update(normalizedData);
    } else {
      await ref.set(normalizedData);
    }
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    final DatabaseReference ref = _database.ref('$table/$key');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final rawData = snapshot.value;
      print("Raw data from Firebase: $rawData");

      if (rawData is LinkedHashMap) {
        return deepConvertLinkedHashMap(rawData);
      } else if (rawData is Map) {
        return Map<String, dynamic>.from(rawData);
      } else {
        print("Unhandled data type: ${rawData.runtimeType}");
      }
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    final DatabaseReference ref = _database.ref(table);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      var rawData = snapshot.value;
      print("Raw data from Firebase: $rawData");

      if (rawData is List) {
        rawData = rawData
            .where((element) => element != null)
            .map((element) {
          if (element is LinkedHashMap) {
            return fixProgressField(Map<String, dynamic>.from(deepConvertLinkedHashMap(element)));
          } else if (element is Map) {
            return fixProgressField(_fixInvalidDatesInMap(Map<String, dynamic>.from(element)));
          } else {
            return element;
          }
        }).toList();
      } else if (rawData is LinkedHashMap) {
        rawData = fixProgressField(Map<String, dynamic>.from(deepConvertLinkedHashMap(rawData)));
      }

      final items = (rawData is List ? rawData : [rawData])
          .map((item) => jsonEncode(item))
          .toList();

      return items
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    }
    return [];
  }

  @override
  Future<void> delete(String table, String key) async {
    final normalizedKey = normalizeKey(key);
    final DatabaseReference ref = _database.ref('$table/$normalizedKey');
    await ref.remove();
  }

  @override
  Future<void> clear(String table) async {
    final DatabaseReference ref = _database.ref(table);
    await ref.remove();
  }

  String normalizeKey(String key) {
    return key.replaceAll(RegExp(r'[.#$/\[\]]'), '_');
  }

  Map<String, dynamic> normalizeDataKeys(Map<String, dynamic> data) {
    final Map<String, dynamic> normalizedData = {};
    data.forEach((key, value) {
      final normalizedKey = normalizeKey(key);
      if (value is Map) {
        normalizedData[normalizedKey] = normalizeDataKeys(Map<String, dynamic>.from(value));
      } else if (value is LinkedHashMap) {
        normalizedData[normalizedKey] = normalizeDataKeys(
            Map<String, dynamic>.from(deepConvertLinkedHashMap(value)));
      } else {
        normalizedData[normalizedKey] = value;
      }
    });
    return normalizedData;
  }

  Map<String, dynamic> deepConvertLinkedHashMap(LinkedHashMap map) {
    final Map<String, dynamic> converted = {};
    map.forEach((key, value) {
      final convertedKey = key.toString();
      if (value is LinkedHashMap) {
        converted[convertedKey] = deepConvertLinkedHashMap(value);
      } else if (value is String && _isInvalidDateFormat(value)) {
        try {
          converted[convertedKey] = _fixDateFormat(value);
        } catch (e) {
          print("Error fixing date format for $value: $e");
          converted[convertedKey] = value;
        }
      } else {
        converted[convertedKey] = value;
      }
    });
    return converted;
  }

  LinkedHashMap deepFixInvalidDateFormats(LinkedHashMap map) {
    final keys = List<dynamic>.from(map.keys);
    for (var key in keys) {
      final value = map[key];
      if (value is String && _isInvalidDateFormat(value)) {
        map[key] = _fixDateFormat(value);
      } else if (value is LinkedHashMap) {
        map[key] = deepFixInvalidDateFormats(value);
      } else if (value is List) {
        map[key] = value.map((item) {
          if (item is String && _isInvalidDateFormat(item)) {
            return _fixDateFormat(item);
          } else if (item is LinkedHashMap) {
            return deepFixInvalidDateFormats(item);
          }
          return item;
        }).toList();
      }
    }
    return map;
  }

  Map<String, dynamic> _fixInvalidDatesInMap(Map<String, dynamic> map) {
    final keys = List<String>.from(map.keys);
    for (var key in keys) {
      final value = map[key];
      if (value is String && _isInvalidDateFormat(value)) {
        map[key] = _fixDateFormat(value);
      } else if (value is Map) {
        map[key] = _fixInvalidDatesInMap(Map<String, dynamic>.from(value));
      } else if (value is List) {
        map[key] = value.map((item) {
          if (item is String && _isInvalidDateFormat(item)) {
            return _fixDateFormat(item);
          } else if (item is Map) {
            return _fixInvalidDatesInMap(Map<String, dynamic>.from(item));
          }
          return item;
        }).toList();
      }
    }
    return map;
  }

  Map<String, dynamic> fixProgressField(Map<String, dynamic> map) {
    if (map.containsKey('progress') && map['progress'] is Map) {
      final progressMap = Map<String, dynamic>.from(map['progress']);
      final keys = List<String>.from(progressMap.keys);

      for (var key in keys) {
        if (key is String && _isInvalidDateFormat(key)) {
          final fixedKey = _fixDateFormat(key);
          progressMap[fixedKey] = progressMap[key];
          progressMap.remove(key);
        }
      }
      map['progress'] = progressMap;
    }
    return map;
  }

  bool _isInvalidDateFormat(String value) {
    return value.contains('T') && value.contains('_');
  }

  String _fixDateFormat(String value) {
    final cleanedValue = value.replaceAll('_000', '.000');
    print("Bypassing validation, returning cleaned value: $cleanedValue");
    return cleanedValue; // Temporärer Workaround
  }
}
