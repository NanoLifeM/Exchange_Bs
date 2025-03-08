import 'package:exchange_bs/data/userdata_object.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(spacing: 20, children: [
            const SizedBox(height: 20,),
                const Center(
          child: CircleAvatar(
            radius: 50,
            child: Icon(Icons.person),
          ),
                ),
                Row(spacing: 3, children: [
                  const SizedBox(width: 5,),
          const Text("userName : ",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16)),
          Text(UserDataObject.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
                Row(spacing: 3, children: [
                  const SizedBox(width: 5,),
          const Text("email : ",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16)),
          Expanded(
            child: Text(UserDataObject.email,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          )
                ]),
                Row(spacing: 3, children: [
                  const SizedBox(width: 5,),
          const Text("token : ",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16)),
          Text(UserDataObject.token,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
                Row(spacing: 3, children: [
                  const SizedBox(width: 5,),
          const Text("password : ",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),),
          Text(UserDataObject.password,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
              ]),
        ));
  }
}
