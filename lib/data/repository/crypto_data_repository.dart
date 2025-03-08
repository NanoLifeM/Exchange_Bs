import 'package:dio/dio.dart';

import '../data_source/get_api.dart';
import '../models/CryptoModel/all_crypto_model.dart';

class CryptoDataRepsitory{
  late Response response;
  late AllCryptoModel dataFuture;
  Future<AllCryptoModel> getTopGainerData() async{


    response = await GetApi().getTopGainersData();
    if(response.statusCode == 200) {
      dataFuture = AllCryptoModel.fromJson(response.data);
    }
    return dataFuture;
  }

}