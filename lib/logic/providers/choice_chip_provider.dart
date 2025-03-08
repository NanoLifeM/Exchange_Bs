import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'crypto_data_provider.dart';

class ChoiceChipProiver extends ChangeNotifier{


  void selectNotify(context,index){
    switch(index){
      case 0:
        Provider.of<CryptoDataProvider>(context,listen: false).getTopMarketCapData();
        break;
      case 1:
        Provider.of<CryptoDataProvider>(context,listen: false).getTopGainersData();
        break;
      case 2:
        Provider.of<CryptoDataProvider>(context,listen: false).getTopLosersData();
        break;
    }
    notifyListeners();
  }

}