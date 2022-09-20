import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurantbooking/screens/customerscreen.dart';
import 'package:restaurantbooking/screens/home_screen.dart';

import '../constant.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  void initState(){
    custom(index);
    super.initState();
  }

  Future<void> custom(int i) async {
    List data = [];

    await FirebaseFirestore.instance.collection("customers").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            //data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));

            i = int.parse(f['id']);
            /*  _questions=data
                .map(
                  (question) => Question(
                  id: question['id'],
                  question: question['question'],
                  options: question['options'],
                  answer: question['answer_index']),
            )
                .toList(); */
            //data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));
          }),
    );
    setState(() {
      index=i+1;
    });
    // _questions =
  }

  TextEditingController customerController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Customer id : $index",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Customer Name",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: customerController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Customer Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Phone Number",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Phone Number',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Address",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Address Here',
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: ((){
                  if(customerController.text.toString().isNotEmpty&&phoneController.text.toString().isNotEmpty&&addressController.text.toString().isNotEmpty)
                    {
                      DocumentReference question = FirebaseFirestore.instance.collection('customers').doc('$index');
                      question.set(
                          {
                            "id": index.toString(),
                            "name": customerController.text.toString(),
                            "phone": phoneController.text.toString(),
                            "address": addressController.text.toString(),
                          }).then((value){

                      });
                      customername = customerController.text.toString();
                      id = index.toString();
                      phone = phoneController.text.toString();
                      address = addressController.text.toString();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CustomerScreen();
                            },
                          )
                      );
                    }
                }),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text("Add Customer",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
                    ),
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
