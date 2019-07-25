import 'package:flutter_test/flutter_test.dart';
import 'package:gitod/models/utils.dart';

void main() {
  test('formatText 3leng', () {
    final counter = formatText("123");
    expect(counter, "123");
  });
  test('formatText 4leng', () {
    final counter = formatText("1234");
    expect(counter, "1,234");
  });
  test('formatText 5leng', () {
    final counter = formatText("12345");
    expect(counter, "12,345");
  });
}
