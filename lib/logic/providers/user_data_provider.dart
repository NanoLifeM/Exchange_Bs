import 'dart:math';
import 'package:exchange_bs/data/data_source/get_api.dart';
import 'package:exchange_bs/data/data_source/response_model.dart';
import 'package:exchange_bs/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';


class UserDataProvider extends ChangeNotifier {
  GetApi apiProvider = GetApi();

  UserModel? dataFuture;
  ResponseModel? registerStatus;
  var error;
  var response;
  final String randomList =
      "1234567890qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM";

  callRegisterApi(name, email, password) async {
    String generateToken = "";

    // start loading api
    registerStatus = ResponseModel.loading("is loading...");
    notifyListeners();
    for (int i = 0; i < 16; i++){
      generateToken+=randomList[(Random().nextInt(randomList.length))];
    }

    try {
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name, email, password);

      if (response.statusCode == 200) {
        dataFuture = UserModel(user: User(name: name, email: email), token: generateToken);

        registerStatus = ResponseModel.completed(dataFuture);

        // have validate error
      }
      notifyListeners();
    } catch (e) {
      // catch any error and show error
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

// callLoginApi(email, password) async {
//
//   loginStatus = Status.LOADING;
//   notifyListeners();
//
//
//   try{
//     response = await apiProvider.loginApi(email, password);
//     if(response.statusCode == 201){
//       dataFuture = UserModel.fromJson(response.data);
//       loginStatus = Status.COMPLETED;
//     }else{
//       dataFuture = ApiStatus.fromJson(response.data);
//       loginStatus = Status.ERROR;
//       error = dataFuture.message;
//     }
//
//     notifyListeners();
//
//
//   }catch(e) {
//     loginStatus = Status.ERROR;
//     error = "please check your connection...";
//     notifyListeners();
//
//     print(e.toString());
//   }
// }

// @override
// void dispose() {
//   loginStatus = null;
// }
}
