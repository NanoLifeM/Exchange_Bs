import 'package:dio/dio.dart';
import 'package:exchange_bs/data/data_source/get_api.dart';
import 'package:exchange_bs/data/data_source/response_model.dart';
import 'package:exchange_bs/data/models/CryptoModel/all_crypto_model.dart';
import 'package:flutter/material.dart';

class MarketViewProvider extends ChangeNotifier {
  GetApi apiProvider = GetApi();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  Response? response;

  getCryptoData() async {

    state = ResponseModel.loading("Loading ....");

    try{
      response = await apiProvider.getAllCryptoData();
      if(response!.statusCode == 200){
        dataFuture = AllCryptoModel.fromJson(response!.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("Something wrong please try again ...");
      }
      notifyListeners();
    }catch(e){
      state = ResponseModel.error("Please check your connection ...");
      notifyListeners();

    }
  }
}
