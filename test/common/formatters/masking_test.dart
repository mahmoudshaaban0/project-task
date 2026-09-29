import 'package:app_template/common/formatters/masking.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('maskName', () {
    test('keeps first and last initials', () {
      expect(maskName('Ahmed Khalid'), 'A•••• K.');
      expect(maskName('Ahmed K.'), 'A•••• K.');
      expect(maskName('Sara Mohammed'), 'S•••• M.');
    });

    test('masks a single name', () {
      expect(maskName('Leo'), 'L••••');
    });

    test('drops middle names and extra whitespace', () {
      expect(maskName('  Omar   bin  Khalid '), 'O•••• K.');
    });

    test('works for Arabic names', () {
      expect(maskName('أحمد خالد'), 'أ•••• خ.');
    });

    test('has the same length whatever the name length', () {
      expect(maskName('Al B').length, maskName('Bartholomew Yves').length);
    });

    test('never returns the empty string', () {
      expect(maskName('   '), '••••');
    });
  });

  test('amount uses a fixed mask', () {
    expect(maskAmount(), 'AED ••,•••.••');
  });
}
