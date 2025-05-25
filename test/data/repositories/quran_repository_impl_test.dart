import 'package:test/test.dart';

void main() {
  test('index.toString() returns expected result', () {
    var index = {
      'number': 1,
      'text': 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'translations_id':
          'Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.',
    }; // Replace with the actual object you want to test
    var expectedResult = '1'; // Replace with the expected string output

    expect(index.toString(), expectedResult);
  });
}
