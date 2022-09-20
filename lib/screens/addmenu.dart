import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'additem.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  void initState(){
    custom(catindex);
    super.initState();
  }

  Future<void> custom(int i) async {
    List data = [];

    await FirebaseFirestore.instance.collection("category").get().then(
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
      catindex=i+1;
    });
    // _questions =
  }

  TextEditingController customerController = new TextEditingController();

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
                  "Category id : $catindex",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10),
                child: Text(
                  "Category Name",
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
                    hintText: 'Enter Category Name',
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: ((){
                  if(customerController.text.toString().isNotEmpty)
                  {
                    DocumentReference question = FirebaseFirestore.instance.collection('category').doc('$catindex');
                    question.set(
                        {
                          "id": catindex.toString(),
                          "name": customerController.text.toString(),
                        }).then((value){

                    });
                    categoryname = customerController.text.toString();
                    categoryid = catindex.toString();
                    itemindex = 0;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddItem();
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
                      child: Center(child: Text("Add Category",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0, color: Colors.white))),
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
