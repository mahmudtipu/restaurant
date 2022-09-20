import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurantbooking/screens/addcustomer.dart';
import 'package:restaurantbooking/screens/categoryitems.dart';
import 'package:restaurantbooking/screens/menucategory.dart';
import 'package:restaurantbooking/screens/takeaway.dart';

import '../constant.dart';
import 'customerscreen.dart';
import 'nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color(0xFF4BC0C8)
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black87, // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: TextField(
            showCursor: false,
            //enableInteractiveSelection: false,
            focusNode: FocusNode(),
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              labelText: "Search by phone",
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu_book,
                color: Colors.black87,
              ),
              onPressed: () {
                Get.to(TakeAway());
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFF4BC0C8),
                    Color(0xFF4BC0C8),
                    Color(0xFF4BC0C8),
                  ]
              )
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("customers").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      documents = snapshot.data!.docs;
                      if (searchText.length > 0) {
                        documents = documents.where((element) {
                          return element
                              .get('phone')
                              .toString()
                              .toLowerCase()
                              .contains(searchText.toLowerCase());
                        }).toList();
                      }
                      return ListView(
                        children: documents.map((document){
                          return Padding(
                            padding: const EdgeInsets.all(14),
                            child: InkWell(
                              onTap: ((){
                                customername = document['name'];
                                id = document['id'];
                                phone = document['phone'];
                                address = document['address'];
                                Get.to(CustomerScreen());
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.blueGrey, width: 1),
                                  shape: BoxShape.rectangle,
                                  //borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10.0,left: 8, bottom: 5),
                                                  child: Text(document['name'],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.black87)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8,top: 5,bottom: 5),
                                                  child: Text(document['address'],style: new TextStyle(color: Colors.black87,fontSize: 16.0)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.call, color: Colors.red,),
                                                      Text(document['phone'],style: new TextStyle(color: Colors.black87,fontSize: 16.0,fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: ((){
                  Get.to(AddCustomer());
                }),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text("Add new customer",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}