import 'package:fakeme/fakeme.dart';

@fakeable
class Population {
  List<User>? users;

  @override
  String toString() {
    return "user$users";
  }
}

@fakeable
class User {
  String? name;
  @fakeable
  List<String>? likes;
  Address? address;

  @override
  String toString() {
    return "name:$name, address:$address,likes:$likes";
  }
}

@fakeable
class Address {
  String? code;
  String? street;

  @override
  String toString() {
    return "code:$code,street:$street";
  }
}
