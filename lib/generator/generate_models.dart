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

  print('🚀 Model generatsiya qilinmoqda...');

  _allBuffer.writeln("import 'package:meta/meta.dart';");
  _allBuffer.writeln("import 'dart:convert';\n");
  _allBuffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

  final rootName = _capitalize(_singularize(fileName)) + 'Model';
  await generateClass(rootName, data, isRoot: true);

  await outFile.writeAsString(_allBuffer.toString());
  print('✅ Tayyor! Modellar -> ${outFile.path}');
}

Future<void> generateClass(String className, dynamic data, {bool isRoot = false}) async {
  if (_generated.contains(className)) return;
  _generated.add(className);

  final buffer = StringBuffer();

  buffer.writeln('class $className {');

  if (data is Map<String, dynamic>) {
    // --- Fields ---
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final type = _getType(key, value);
      buffer.writeln('  final $type ${_camelCase(key)};');
    }

    // --- Constructor ---
    buffer.write('\n  $className({');
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final type = _getType(key, value);
      final isNullable = type.endsWith('?');
      buffer.write('${isNullable ? '' : 'required '}this.${_camelCase(key)}, ');
    }
    buffer.writeln('});\n');

    // --- copyWith ---
    buffer.writeln('  $className copyWith({');
    for (final entry in data.entries) {
      final key = entry.key;
      final type = _getType(key, entry.value).replaceAll('?', '');
      buffer.writeln('    $type? ${_camelCase(key)},');
    }
    buffer.writeln('  }) => $className(');
    for (final entry in data.entries) {
      final key = entry.key;
      buffer.writeln('    ${_camelCase(key)}: ${_camelCase(key)} ?? this.${_camelCase(key)},');
    }
    buffer.writeln('  );\n');

    // --- JSON helpers ---
    buffer.writeln('  factory $className.fromRawJson(String str) => $className.fromJson(json.decode(str));');
    buffer.writeln('  String toRawJson() => json.encode(toJson());\n');

    // --- fromJson ---
    buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) => $className(');
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final type = _getType(key, value);
      final field = _camelCase(key);

      if (type.startsWith('List<')) {
        final inner = type.substring(5, type.length - (type.endsWith('>?') ? 2 : 1));
        if (_isPrimitive(inner)) {
          buffer.writeln("    $field: json['$key'] == null ? [] : List<$inner>.from(json['$key']),");
        } else {
          buffer.writeln("    $field: json['$key'] == null ? [] : List<$inner>.from(json['$key'].map((x) => $inner.fromJson(x))),");
        }
      } else if (!_isPrimitive(type.replaceAll('?', ''))) {
        buffer.writeln("    $field: json['$key'] == null ? null : ${type.replaceAll('?', '')}.fromJson(json['$key']),");
      } else {
        buffer.writeln("    $field: json['$key'],");
      }
    }
    buffer.writeln('  );\n');

    // --- toJson ---
    buffer.writeln('  Map<String, dynamic> toJson() => {');
    for (final entry in data.entries) {
      final key = entry.key;
      final type = _getType(key, entry.value);
      final field = _camelCase(key);

      if (type.startsWith('List<')) {
        buffer.writeln("    '$key': $field.map((x) => x is Map ? x : (x as dynamic).toJson()).toList(),");
      } else if (!_isPrimitive(type.replaceAll('?', ''))) {
        buffer.writeln("    '$key': $field${type.endsWith('?') ? '?' : ''}.toJson(),");
      } else {
        buffer.writeln("    '$key': $field,");
      }
    }
    buffer.writeln('  };');
  }

  buffer.writeln('}\n');
  _allBuffer.writeln(buffer.toString());

  // --- Rekursiv obyektlar ---
  if (data is Map<String, dynamic>) {
    for (var entry in data.entries) {
      if (entry.value is Map<String, dynamic>) {
        await generateClass(_capitalize(_singularize(entry.key)), entry.value);
      } else if (entry.value is List && entry.value.isNotEmpty) {
        final first = entry.value.first;
        if (first is Map<String, dynamic>) {
          await generateClass(_capitalize(_singularize(entry.key)), first);
        }
      }
    }
  }
}

// --------------------------------------------------
// 🔹 Type aniqlash
// --------------------------------------------------

String _getType(String key, dynamic value) {
  if (value == null) return 'dynamic';
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is bool) return 'bool';
  if (value is String) return 'String';
  if (value is List) {
    if (value.isEmpty) return 'List<dynamic>';
    final first = value.first;
    if (first is Map<String, dynamic>) return 'List<${_capitalize(_singularize(key))}>';
    if (first is int) return 'List<int>';
    if (first is double) return 'List<double>';
    if (first is String) return 'List<String>';
    return 'List<dynamic>';
  }
  if (value is Map<String, dynamic>) {
    return '${_capitalize(_singularize(key))}?'; // Nullable obyektlar uchun
  }
  return 'dynamic';
}

bool _isPrimitive(String type) =>
    ['int', 'double', 'bool', 'String', 'dynamic'].contains(type);

// --------------------------------------------------
// 🔹 Matn ishlovchi yordamchi funksiyalar
// --------------------------------------------------

String _capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

String _camelCase(String s) {
  if (s.isEmpty) return s;
  final parts = s.split('_');
  return parts.first + parts.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
}

// 🔹 Gramatik jihatdan yaxshilangan singularize
String _singularize(String s) {
  final lower = s.toLowerCase();

  // Istisnolar
  const exceptions = {
    'news': 'news',
    'class': 'class',
    'status': 'status',
    'series': 'series',
    'species': 'species',
  };
  if (exceptions.containsKey(lower)) return exceptions[lower]!;

  if (lower.endsWith('ies')) return s.substring(0, s.length - 3) + 'y';
  if (lower.endsWith('ses')) return s.substring(0, s.length - 2);
  if (lower.endsWith('xes')) return s.substring(0, s.length - 2);
  if (lower.endsWith('zes')) return s.substring(0, s.length - 2);
  if (lower.endsWith('ches')) return s.substring(0, s.length - 2);
  if (lower.endsWith('shes')) return s.substring(0, s.length - 2);
  if (lower.endsWith('s') && !lower.endsWith('ss')) return s.substring(0, s.length - 1);
  return s;
}
