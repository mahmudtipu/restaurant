import 'package:cloud_firestore/cloud_firestore.dart';

String customername = "";
String id = "";
String phone = "";
String address = "";

String categoryname = "";
String catname = "";
String categoryid = "";

//add to cart items

String cartimage = '';
String cartname = '';
String cartprice = '';
String cartdesc = '';
List<DocumentSnapshot> doc = [];

int index = 0;
int catindex = 0;
int itemindex = 0;
int totalbill = 0;