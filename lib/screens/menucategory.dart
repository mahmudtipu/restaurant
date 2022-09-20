import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurantbooking/screens/categoryitems.dart';

import '../constant.dart';

class MenuCategory extends StatefulWidget {
  const MenuCategory({Key? key}) : super(key: key);

  @override
  _MenuCategoryState createState() => _MenuCategoryState();
}

class _MenuCategoryState extends State<MenuCategory> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color(0xFF4BC0C8)
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
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
              labelText: "Search by category",
            ),
          ),
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
                    stream: FirebaseFirestore.instance.collection("category").snapshots(),
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
                              .get('name')
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
                                categoryname = document['name'];
                                categoryid = document['id'];
                                Get.to(CategoryItems());
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.blueGrey, width: 1),
                                  shape: BoxShape.rectangle,
                                  //borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0,left: 8, bottom: 5),
                                          child: Text(document['name'],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.black87)),
                                        ),
                                      ],
                                    ),
                                  )
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
            ],
          ),
        )
    );
  }
}
