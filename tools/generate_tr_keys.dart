// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/translations/en.json');
  final Map<String, dynamic> translations =
      json.decode(file.readAsStringSync());

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln();
  buffer.writeln('class TrKeys {');

  for (final key in translations.keys) {
    buffer.writeln('  static const String ${key} = \'$key\';');
  }

  buffer.writeln('}');

  final outputFile = File('lib/app/l10n/tr_keys.dart');
  outputFile.writeAsStringSync(buffer.toString());

  print('Generated tr_keys.dart successfully!');
}
