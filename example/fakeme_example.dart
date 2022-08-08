import 'package:fakeme/fakeme.dart';

import 'fakeme_example.reflectable.dart';
import 'models/user.dart';

void main() {
  // add package build_runner and reflectable and initializeReflectable
  initializeReflectable();
  var awesome = FakeMe();
  print('awesome: ${awesome.generate<User>()}');
}
