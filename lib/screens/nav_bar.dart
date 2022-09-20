import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurantbooking/screens/takeawayorder.dart';

import 'customizemenu.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  String phone = '';
  String name = '';
  String address = '';

  @override
  void initState(){
    super.initState();
    getPhone();
    fetchprof();
  }

  getPhone() async{
    User currentUser = await FirebaseAuth.instance.currentUser!;
    setState(() {
      phone=currentUser.phoneNumber!;
    });
  }

  Future<void> fetchprof() async {
    String na='',add='';
    await FirebaseFirestore.instance.collection("userdetails").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            na= f.data()['name'];
            add= f.data()['address'];
          }),
    );
    setState(() {
      name = na;
      address = add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: Text('Customize Menu'),
              onTap: ((){
                Get.to(CustomizeMenu());
              }),
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings_rounded),
              title: Text('Add Admin'),
              onTap: ((){
                //Get.to(ProfileScreen());
              }),
            ),
            ListTile(
              leading: Icon(Icons.done_outline),
              title: Text('Completed Order'),
              onTap: ((){
                //Get.to(Delivery());
              }),
            ),
          ],
        ),
      ),
    );
  }
}