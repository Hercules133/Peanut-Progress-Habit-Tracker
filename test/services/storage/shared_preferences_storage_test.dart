import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/services/storage/shared_preferences_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferencesStorage storage;
  SharedPreferences.setMockInitialValues({});

  setUp(() {
    storage = SharedPreferencesStorage();
  });

  group('SharedPreferencesStorage', () {
    test('should save and read data correctly', () async {
      final data = {'id': '1', 'name': 'test'};
      await storage.save('test_table1', data, (item) => item['id']);
      final result = await storage.read('test_table1', 'id');
      expect(result, data);
    });

    test('should read all data correctly', () async {
      final data1 = {'id': '1', 'name': 'test1'};
      final data2 = {'id': '2', 'name': 'test2'};
      await storage.save('test_table2', data1, (item) => item['id']);
      await storage.save('test_table2', data2, (item) => item['id']);
      final result = await storage.readAll('test_table2');
      expect(result, [data1, data2]);
    });

    test('should delete data correctly', () async {
      final data = {'id': '1', 'name': 'test'};
      await storage.save('test_table3', data, (item) => item['id']);
      await storage.delete('test_table3', '1');
      final result = await storage.read('test_table3', 'id');
      expect(result, isNull);
    });

    test('should clear data correctly', () async {
      final data = {'id': '1', 'name': 'test'};
      await storage.save('test_table4', data, (item) => item['id']);
      await storage.clear('test_table4');
      final result = await storage.readAll('test_table4');
      expect(result, isEmpty);
    });
  });
}