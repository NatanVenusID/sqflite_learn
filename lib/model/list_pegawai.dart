import 'package:flutter/material.dart';

import 'package:sqlite_app/model/db_helper.dart';
import 'package:sqlite_app/model/detailpage.dart';
import 'package:sqlite_app/model/form_pegawai.dart';
import 'package:sqlite_app/model/model_pegawai.dart';
class ListPegawai extends StatefulWidget {
@override
 _ListPegawaiState createState() => _ListPegawaiState();
}
class _ListPegawaiState extends State<ListPegawai> {
List<ModelPegawai> items = new List();
 DatabaseHelper db = new DatabaseHelper();
@override
void initState() {
 // TODO: implement initState
 super.initState();
 db.getAllPegawai().then((pegawais) {
 setState(() {
 pegawais.forEach((pegawai) {
 items.add(ModelPegawai.fromMap(pegawai));
 });
 });
 });
 }
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('List Pegawai'),
 backgroundColor: Colors.red,
 ),
 body: ListView.builder(
 itemCount: items.length,
 itemBuilder: (context, index) {
 return ListTile(
 contentPadding: EdgeInsets.only(left: 16),
 title: Text(
   '${items[index].firstname} ${items[index].lastname}',
 style: TextStyle(
 fontSize: 18,
 fontStyle: FontStyle.italic,
 color: Colors.deepOrangeAccent),
 ),
 subtitle: Text(
 '${items[index].emailid}',
 ),
 onTap: () {
 _navigateToPegawai(context, items[index]);
 },
 trailing: IconButton(
 icon: Icon(Icons.delete),
 onPressed: () {
 AlertDialog hapus = AlertDialog(
 title: Text('Information'),
 content: Container(
 height: 100.0,
 child: Column(
 children: <Widget>[
 Text(
 'Apakah anda yakin ingin hapus data${items[index].firstname}')
 ],
 ),
 ),
 actions: <Widget>[
 FlatButton(
 child: Text('yes'),
 onPressed: () {
 _deletePegawai(context, items[index],
index);
 Navigator.pop(context);
 },
 ),
 FlatButton(
 child: Text('no'),
 onPressed: () {
 Navigator.pop(context);
 },
 ),
 ],
 );
 showDialog(context: context, child: hapus);
 },),
 leading:
 IconButton(
 onPressed: () {
 Navigator.push(context, MaterialPageRoute(builder:
(context) => PageDetail(
 pertama : items[index].firstname, terakhir:
items[index].lastname,
 phone : items[index].mobileno, email :
items[index].emailid
 )));
 },
 icon: Icon(Icons.visibility),
 ),
 );
 }),
 floatingActionButton: FloatingActionButton(
 child: Icon(Icons.add),
 backgroundColor: Colors.red,
 onPressed: () {
 _createNewPegawai(context);
 }),
 );
 }
 _deletePegawai(BuildContext context, ModelPegawai pegawai, int
position) {
 db.deletePegawai(pegawai.id).then((pegawais) {
 setState(() {
 items.removeAt(position);
 });
 });
 }
void _navigateToPegawai(BuildContext context, ModelPegawai pegawai)
async {
 String result = await Navigator.push(
 context, MaterialPageRoute(builder: (context) =>
FormPegawai(pegawai)));
 if (result == 'update') {
 db.getAllPegawai().then((pegawais) {
 setState(() {
 items.clear();
 pegawais.forEach((pegawai) {
 items.add(ModelPegawai.fromMap(pegawai));
 });
 });
 });
 }
 }
void _createNewPegawai(BuildContext context) async {
 String result = await Navigator.push(
 context,
 MaterialPageRoute(
 builder: (context) => FormPegawai(ModelPegawai('', '', '',
''))));
 if (result == 'save') {
 db.getAllPegawai().then((pegawais) {
 setState(() {
 items.clear();
 pegawais.forEach((pegawai) {
 items.add(ModelPegawai.fromMap(pegawai));
 });
 });
 });
 }
 }
}