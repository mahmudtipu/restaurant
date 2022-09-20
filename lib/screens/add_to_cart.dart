import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int price = int.parse(cartprice);
  int totalprice = int.parse(cartprice);
  int itemcount = 1;
  int index = 0;

  @override
  void initState(){
    fetch(index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(cartname,style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.black87)),
                  Spacer(),
                  Icon(Icons.euro, color: Colors.black54,),
                  Text('$totalprice',style: new TextStyle(color: Colors.black87, fontSize: 20)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: ((){
                      setState(() {
                        if(itemcount>1)
                        {
                          totalprice = totalprice - price;
                          itemcount--;
                        }
                      });
                    }),
                    child: Container(width: 50, color: Color(0xFF4BC0C8), child: Center(child: Text("-",style: new TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0, color: Colors.white)))),
                  ),
                  Container(width: 50, color: Color(0xFF4BC0C8), child: Center(child: Text('$itemcount',style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.white)))),
                  InkWell(
                    onTap: ((){
                      setState(() {
                        totalprice = price + totalprice;
                        itemcount++;
                      });
                    }),
                    child: Container(width: 50, color: Color(0xFF4BC0C8), child: Center(child: Text("+",style: new TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0, color: Colors.white)))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20.0),
              child: Text(cartdesc,style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0, color: Colors.black87)),
            ),
            Spacer(),
            InkWell(
              onTap: ((){
                index++;

                DocumentReference question = FirebaseFirestore.instance.collection('deliverydetails').doc(id).collection('cart').doc('$index');
                question.set(
                    {
                      "index": index,
                      "customerid": id,
                      "name": cartname,
                      "price": totalprice,
                      "quantity": itemcount,
                    }).then((value){

                });

                Get.back();
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  color: Color(0xFF4BC0C8),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(child: Text("Add to cart",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetch(int i) async {
    await FirebaseFirestore.instance.collection("deliverydetails").doc(id).collection('cart').get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            i = f['index'];
          }),
    );
    setState(() {
      index=i;
    });
  }
}
