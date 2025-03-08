
import 'package:flutter/material.dart';

class IsObsecurePasswordProvider extends ChangeNotifier{
  bool isObsecure=true;

  void changeIsObsecure(){
    isObsecure = !isObsecure;
    notifyListeners();
  }
}