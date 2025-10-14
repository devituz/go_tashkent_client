// ishlash tartibi: dart run lib/generator/generate_models.dart basket
// har doim lib ichidagi generator ichida bo‘lsin

import 'dart:convert';
import 'dart:io';

final Set<String> _generated = {};
final StringBuffer _allBuffer = StringBuffer();

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Foydalanish: dart run lib/generator/generate_models.dart <fileName>');
    print('   Masalan: dart run lib/generator/generate_models.dart basket');
    return;
  }

  final fileName = args.first;
  final inputFile = File('${Directory.current.path}/lib/generator/$fileName.json');

  if (!await inputFile.exists()) {
    print('❌ JSON topilmadi: ${inputFile.path}');
    return;
  }

  final jsonStr = await inputFile.readAsString();
  final data = jsonDecode(jsonStr);

  final outFile = File('${Directory.current.path}/lib/generator/${fileName}_models.dart');

  print('🚀 model generatsiya qilinmoqda...');

  _allBuffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

  await generateClass(_capitalize(fileName), data);

  await outFile.writeAsString(_allBuffer.toString());

  print('✅ Tayyor! Modellar -> ${outFile.path}');
}

Future<void> generateClass(String className, dynamic data) async {
  if (_generated.contains(className)) return;
  _generated.add(className);

  final buffer = StringBuffer();
  buffer.writeln('class $className {');

  if (data is Map<String, dynamic>) {
    // Fields
    data.forEach((key, value) {
      buffer.writeln('  final ${_getType(key, value, nullable: true)} ${_camelCase(key)};');
    });

    // Constructor
    buffer.write('\n  const $className({');
    data.forEach((key, value) {
      final type = _getType(key, value, nullable: true);
      if (type.startsWith('List<')) {
        buffer.write('this.${_camelCase(key)} = const [], ');
      } else {
        buffer.write('this.${_camelCase(key)}, ');
      }
    });
    buffer.writeln('});');

    // ✅ fromJson factory
    buffer.writeln('\n  factory $className.fromJson(Map<String, dynamic> json) {');
    buffer.writeln('    return $className(');
    data.forEach((key, value) {
      final type = _getType(key, value, nullable: true);
      final fieldName = _camelCase(key);

      if (type.startsWith('List<')) {
        final innerType = type.substring(5, type.length - 1);
        if (_isPrimitive(innerType)) {
          buffer.writeln('      $fieldName: (json[\'$key\'] as List<dynamic>?)?.cast<$innerType>() ?? const [],');
        } else {
          buffer.writeln('      $fieldName: (json[\'$key\'] as List<dynamic>?)?.map((e) => $innerType.fromJson(e as Map<String, dynamic>)).toList() ?? const [],');
        }
      } else if (type == 'double?') {
        buffer.writeln('      $fieldName: (json[\'$key\'] as num?)?.toDouble(),');
      } else if (!_isPrimitive(type.replaceAll('?', ''))) {
        buffer.writeln('      $fieldName: json[\'$key\'] != null ? ${type.replaceAll('?', '')}.fromJson(json[\'$key\']) : null,');
      } else {
        buffer.writeln('      $fieldName: json[\'$key\'] as $type,');
      }
    });
    buffer.writeln('    );');
    buffer.writeln('  }');

    // ✅ toJson
    buffer.writeln('\n  Map<String, dynamic> toJson() {');
    buffer.writeln('    return {');
    data.forEach((key, value) {
      final type = _getType(key, value, nullable: true);
      final fieldName = _camelCase(key);

      if (type.startsWith('List<')) {
        buffer.writeln('      \'$key\': $fieldName.map((e) => e is Map ? e : (e as dynamic).toJson()).toList(),');
      } else if (!_isPrimitive(type.replaceAll('?', ''))) {
        buffer.writeln('      \'$key\': $fieldName?.toJson(),');
      } else {
        buffer.writeln('      \'$key\': $fieldName,');
      }
    });
    buffer.writeln('    };');
    buffer.writeln('  }');
  }

  buffer.writeln('}\n');
  _allBuffer.writeln(buffer.toString());

  // Rekursiv classlar
  if (data is Map<String, dynamic>) {
    for (var entry in data.entries) {
      if (entry.value is Map<String, dynamic>) {
        await generateClass(_capitalize(_singularize(entry.key)), entry.value);
      } else if (entry.value is List && entry.value.isNotEmpty && entry.value.first is Map<String, dynamic>) {
        await generateClass(_capitalize(_singularize(entry.key)), entry.value.first);
      }
    }
  }
}

String _getType(String key, dynamic value, {bool nullable = false}) {
  String type;
  if (value is int) type = 'int';
  else if (value is double) type = 'double';
  else if (value is bool) type = 'bool';
  else if (value is String) type = 'String';
  else if (value is List) {
    if (value.isNotEmpty && value.first is Map<String, dynamic>) {
      type = 'List<${_capitalize(_singularize(key))}>';
    } else {
      type = 'List<dynamic>';
    }
    return type;
  } else if (value is Map<String, dynamic>) {
    type = _capitalize(_singularize(key));
  } else {
    type = 'dynamic';
  }

  return nullable && type != 'dynamic' ? '$type?' : type;
}

bool _isPrimitive(String type) => ['int', 'double', 'bool', 'String', 'dynamic'].contains(type);

String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

String _camelCase(String s) {
  if (s.isEmpty) return s;
  final parts = s.split('_');
  return parts.first + parts.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
}

/// oddiy plural -> singular
String _singularize(String s) {
  if (s.endsWith('ies')) {
    return s.substring(0, s.length - 3) + 'y'; // categories -> category
  } else if (s.endsWith('s') && !s.endsWith('ss')) {
    return s.substring(0, s.length - 1); // items -> item
  }
  return s;
}
