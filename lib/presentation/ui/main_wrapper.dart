import 'package:exchange_bs/presentation/ui/home_page.dart';
import 'package:exchange_bs/presentation/ui/market_view_page.dart';
import 'package:exchange_bs/presentation/ui/profile_page.dart';
import 'package:exchange_bs/presentation/ui/ui_helper/bottom_nav.dart';
import 'package:exchange_bs/presentation/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.blueAccent[400],
        shape:const CircleBorder(),

        child:const Icon(Icons.compare_arrows_outlined,color: Colors.white,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: _myPage,),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _myPage,
        children:  const[
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage(),
        ],
      ),
    );
  }
}
