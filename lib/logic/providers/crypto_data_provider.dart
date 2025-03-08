import 'package:exchange_bs/data/data_source/get_api.dart';
import 'package:exchange_bs/data/data_source/response_model.dart';
import 'package:exchange_bs/data/models/CryptoModel/all_crypto_model.dart';
import 'package:exchange_bs/data/repository/crypto_data_repository.dart';
import 'package:flutter/material.dart';


class CryptoDataProvider extends ChangeNotifier{
  GetApi getApi= GetApi();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var  response;
  getTopMarketCapData()async{
    state = ResponseModel.loading("is loading ...");

    try{
      response = await GetApi().getTopMarketCapData();
      if(response.statusCode == 200){
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("Wrong .....");
      }
      notifyListeners();
    }catch(e){
      state = ResponseModel.error("Please check Connection.....");
      notifyListeners();
    }

}

  getTopGainersData()async{
    state = ResponseModel.loading("is loading ...");

    try{


        dataFuture =await CryptoDataRepsitory().getTopGainerData() ;
        if(dataFuture.data != null) {
          state = ResponseModel.completed(dataFuture);
        } else {
        state = ResponseModel.error("Wrong .....");
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.error("Please check Connection.....");
      notifyListeners();
    }

  }

  getTopLosersData()async{
    state = ResponseModel.loading("is loading ...");

    try{
      response = await GetApi().getTopLosersData();
      if(response.statusCode == 200){
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("Wrong .....");
      }
      notifyListeners();
    }catch(e){
      state = ResponseModel.error("Please check Connection.....");
      notifyListeners();
    }

  }
}