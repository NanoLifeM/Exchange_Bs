import 'package:exchange_bs/data/userdata_object.dart';

import 'logic/providers/choice_chip_provider.dart';
import 'logic/providers/crypto_data_provider.dart';
import 'logic/providers/theme_provider.dart';
import 'presentation/ui/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/providers/is_obsecure_password_provider.dart';
import 'logic/providers/market_view_provider.dart';
import 'logic/providers/user_data_provider.dart';
import 'presentation/ui/sign_up_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
      ChangeNotifierProvider(create: (context) => ChoiceChipProiver()),
      ChangeNotifierProvider(create: (context) => MarketViewProvider()),
      ChangeNotifierProvider(create: (context) => IsObsecurePasswordProvider()),
      ChangeNotifierProvider(create: (context) => UserDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home:FutureBuilder(future: SharedPreferences.getInstance(), builder: (context,snapShot){
          if(snapShot.hasData){
            SharedPreferences sharedPreferences=snapShot.data!;
            var loggedInState=sharedPreferences.getBool("LoggedIn") ?? false;

            if(loggedInState){
              UserDataObject.userName = sharedPreferences.getString('user_name')!;
              UserDataObject.password = sharedPreferences.getString('user_password')!;
              UserDataObject.email = sharedPreferences.getString('user_email')!;
              UserDataObject.token = sharedPreferences.getString('user_token')!;
              return const MainWrapper();
            }
            else{
              return const SignUpScreen();
            }

          }
          else{
            return const Center(child:  CircularProgressIndicator());
          }
        }),
      );
    });
  }
}
