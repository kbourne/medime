

import 'package:flutter/cupertino.dart';

class Muser extends ChangeNotifier {
String? _name;
  String? _email;
  String? _photoUrl;
  String? _uid;
  String? _token;

  String? get name => _name;
  String? get email => _email;
  String? get photoUrl => _photoUrl;
  String? get uid => _uid;
  String? get token => _token;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPhotoUrl(String photoUrl) {
    _photoUrl = photoUrl;
    notifyListeners();
  }

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}