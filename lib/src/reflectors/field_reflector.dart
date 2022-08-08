import 'package:reflectable/reflectable.dart';

class FieldReflector extends Reflectable {
  const FieldReflector()
      : super(
          typeAnnotationQuantifyCapability,
          invokingCapability,
          declarationsCapability,
          reflectedTypeCapability,
          metadataCapability,
          staticInvokeCapability,
          instanceInvokeCapability,
          topLevelInvokeCapability,
          instanceInvokeCapability,
          typeRelationsCapability,
        );
}
