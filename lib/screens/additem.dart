import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  void initState(){
    custom(itemindex);
    super.initState();
  }

  Future<void> custom(int i) async {
    List data = [];

    await FirebaseFirestore.instance.collection("category").doc(categoryid).collection("fooditem").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            i = int.parse(f['id']);
          }),
    );
    setState(() {
      itemindex=i+1;
    });
    // _questions =
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

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
                  "Item no : $itemindex",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Item Name",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Item Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Price",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Price',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Description",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: ((){
                  if(nameController.text.toString().isNotEmpty&&priceController.text.toString().isNotEmpty&&descController.text.toString().isNotEmpty)
                  {
                    DocumentReference question = FirebaseFirestore.instance.collection('category').doc(categoryid).collection("fooditem").doc('$itemindex');
                    question.set(
                        {
                          "id": itemindex.toString(),
                          "name": nameController.text.toString(),
                          "price": priceController.text.toString(),
                          "description": descController.text.toString(),
                        }).then((value){

                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddItem();
                          },
                        )
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Item added'),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                }),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text("Add Item",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
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
