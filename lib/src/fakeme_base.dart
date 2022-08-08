// TODO: Put public facing types in this file.

import 'dart:math' show Random;

import 'package:reflectable/reflectable.dart';

import 'reflectors/field_reflector.dart';

const fakeable = FieldReflector();

/// Checks if you are awesome. Spoiler: you are.
class FakeMe {
  List<String> primaryTypes = ["int", "double", "String", 'List'];
  fakeType(Type type, {String? fieldName}) {
    if (type == int) {
      return Random().nextInt(100) + 1;
    } else if (type == String) {
      return "value${Random().nextInt(100) + 1}";
    }
  }

  List<T> generate<T>([int count = 1, Type? type]) {
    List<T> results = [];
    late ClassMirror classMirror;
    if (type != null) {
      classMirror = fakeable.reflectType(type) as ClassMirror;
    } else {
      classMirror = fakeable.reflectType(T) as ClassMirror;
    }

    for (var i = 0; i < count; i++) {
      print(classMirror.reflectedType);

      try {
        classMirror.newInstance("", []);
      } catch (e) {
        if (type != null) {
          print(type.toString());
          results.add(fakeType(type));
          continue;
        }
        print("END ERROR\n");
      }
      var t = classMirror.newInstance("", []);
      var aInstanceMirror = fakeable.reflect(t);
      for (var field in classMirror.declarations.values) {
        if (field is! VariableMirror) continue;
        VariableMirror variableMirror = field;
        if (!primaryTypes.contains(variableMirror.type.simpleName)) {
          Type fieldType = variableMirror.type.reflectedType;

          var value = generate(1, fieldType)[0];
          aInstanceMirror.invokeSetter(variableMirror.simpleName, value);
        } else {
          if (variableMirror.type.simpleName == "List") {
            Type fieldType = variableMirror.type.reflectedTypeArguments.first;
            var value = generate(3, fieldType);
            print(value);
            //TODO : type 'List<dynamic>' is not a subtype of type 'List<String>?' of 'value'
            aInstanceMirror.invokeSetter(variableMirror.simpleName, value);
          } else {
            Type fieldType = variableMirror.type.reflectedType;
            var value = fakeType(fieldType);
            aInstanceMirror.invokeSetter(variableMirror.simpleName, value);
          }
        }
      }
      if (type != null) {
        results.add(t as T);
      } else {
        results.add(t as T);
      }
    }

    return results;
  }
}
