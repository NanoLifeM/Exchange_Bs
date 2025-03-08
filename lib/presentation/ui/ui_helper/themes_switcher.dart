import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/providers/theme_provider.dart';

class ThemesSwitcher extends StatefulWidget {
  const ThemesSwitcher({super.key});

  @override
  State<ThemesSwitcher> createState() => _ThemesSwitcherState();
}

class _ThemesSwitcherState extends State<ThemesSwitcher> {
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    var switchIcon=(themeProvider.isDarkMode ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill);
    return IconButton(
        icon: Icon(switchIcon,color: Colors.white,) ,
        onPressed: (){
          themeProvider.toggleTheme();

        });
  }
}
