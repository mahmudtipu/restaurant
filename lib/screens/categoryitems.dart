import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurantbooking/constant.dart';

import 'add_to_cart.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key}) : super(key: key);

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
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
        title: Text(categoryname, style: TextStyle(color: Colors.black87),),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFF4BC0C8)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 40, right: 40),
              child: TextField(
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
                  labelText: "Search by food",
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("category").doc(categoryid).collection("fooditem").snapshots(),
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
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: 1),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(
                                child: ListTile(
                                  onTap: ((){

                                  }),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(document['name'],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.black87)),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(Icons.euro, color: Colors.black54,),
                                      Text(document['price'],style: new TextStyle(color: Colors.black87)),
                                      Spacer(),
                                      InkWell(
                                        onTap: ((){
                                          cartname = document['name'];
                                          cartprice = document['price'];
                                          cartdesc = document['description'];
                                          Get.to(AddToCart());
                                        }),
                                        child: Container(
                                          width: 100,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black87, width: 1),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            gradient: LinearGradient(
                                              colors: [Colors.black54, Colors.black54],
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                                ("Add item"),
                                                style: new TextStyle(color: Colors.white)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
          ],
        ),
      ),
    );
  }
}
