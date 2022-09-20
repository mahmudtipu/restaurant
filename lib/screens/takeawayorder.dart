import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class TakeAwayOrder extends StatefulWidget {
  const TakeAwayOrder({Key? key}) : super(key: key);

  @override
  _TakeAwayOrderState createState() => _TakeAwayOrderState();
}

class _TakeAwayOrderState extends State<TakeAwayOrder> {
  List<DocumentSnapshot> documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("takeawaydetails").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      documents = snapshot.data!.docs;

                      if(documents.length>0)
                      {
                        doc = documents;
                        return Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children: documents.map((document){
                                  int a = int.parse(document['price'].toString());
                                  totalbill = totalbill+a;
                                  String price = document['price'].toString();
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
                                                child: Row(
                                                  children: [
                                                    Text(document['name'],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.black87)),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0),
                                                      child: Text("X "+document['quantity'].toString(),style: new TextStyle(fontSize: 18.0, color: Colors.black87)),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Icon(Icons.euro, color: Colors.black54,),
                                                Text(price,style: new TextStyle(color: Colors.black87)),
                                                Spacer(),
                                                InkWell(
                                                  onTap: ((){
                                                    FirebaseFirestore.instance.collection("takeawaydetails")
                                                        .doc(document["index"].toString())
                                                        .delete();
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
                                                          ("Delete"),
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
                              ),
                            ),
                            InkWell(
                              onTap: ((){
                                //Get.to(OrderScreen());
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.black54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(child: Text("Print Now",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      else
                      {
                        return Center(
                          child: Text('Empty'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
