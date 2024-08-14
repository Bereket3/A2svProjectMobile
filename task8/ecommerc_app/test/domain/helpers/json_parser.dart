import 'dart:io';

String readJson(String name) {
  return File('test/domain/helpers/dummy_data/$name').readAsStringSync();
}