import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
   const BottomNav({super.key,required this.controller});
   final controller;
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    final primaryColor= Theme.of(context).primaryColor;
    return BottomAppBar(
      height: 63,
      color: primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      padding:const EdgeInsets.all(0),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
               SizedBox(
                width: (size.width/2)-20,
                height: 50,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     IconButton(onPressed: (){
                       controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                     }, icon:const Icon(Icons.home)),
                     IconButton(onPressed: (){
                       controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                     }, icon:const Icon(Icons.bar_chart)),
                   ],
                 ),
              ),
            SizedBox(
                width: (size.width/2)-20,
                height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    controller.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, icon:const Icon(Icons.person)),
                  IconButton(onPressed: (){
                    controller.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, icon:const Icon(Icons.bookmark)),
                ],
              ),
              ),

          ],
        ),


    );
  }
}
