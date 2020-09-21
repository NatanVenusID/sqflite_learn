import 'package:flutter/material.dart';
class PageDetail extends StatelessWidget {
String pertama,terakhir,email,phone;
 PageDetail({this.pertama,this.terakhir,this.email,this.phone});
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('Detail Pegawai'),
 ),
 body: Center(
 child: Column(
 children: <Widget>[
 Text('First Name : $pertama'),
 Text('Last Name : $terakhir'),
 Text('Number Phone : $phone'),
 Text('Email Address : $email'),
 ],
 ),
 ),
 );
 }
}
