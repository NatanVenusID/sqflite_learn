import 'package:flutter/material.dart';
import 'package:sqlite_app/model/db_helper.dart';
import 'package:sqlite_app/model/model_pegawai.dart';
class FormPegawai extends StatefulWidget {
final ModelPegawai modelPegawai;
 FormPegawai(this.modelPegawai);
@override
 _FormPegawaiState createState() => _FormPegawaiState();
}
class _FormPegawaiState extends State<FormPegawai> {
 DatabaseHelper db = new DatabaseHelper();
 TextEditingController _firstNameControler;
 TextEditingController _lastNameControler;
 TextEditingController _mobileNoControler;
 TextEditingController _emailIdControler;
@override
void initState() {
 // TODO: implement initState
 super.initState();
 _firstNameControler =
 new TextEditingController(text:
widget.modelPegawai.firstname);
 _lastNameControler =
 new TextEditingController(text: widget.modelPegawai.lastname);
 _mobileNoControler =
 new TextEditingController(text: widget.modelPegawai.mobileno);
 _emailIdControler =
 new TextEditingController(text: widget.modelPegawai.emailid);
 }
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('Form Pegawai'),
 backgroundColor: Colors.red,
 ),
 body: ListView(
 padding: EdgeInsets.all(16),
 children: <Widget>[
   TextField(
 controller: _firstNameControler,
 decoration: InputDecoration(
 labelText: 'First Name',
 border: OutlineInputBorder(
 borderRadius: BorderRadius.circular(20))),
 ),
 SizedBox(
 height: 5,
 ),
 TextField(
 controller: _lastNameControler,
 decoration: InputDecoration(
 labelText: 'Last Name',
 border: OutlineInputBorder(
 borderRadius: BorderRadius.circular(20))),
 ),
 SizedBox(
 height: 5,
 ),
 TextField(
 controller: _mobileNoControler,
 decoration: InputDecoration(
 labelText: 'Number Phone',
 border: OutlineInputBorder(
 borderRadius: BorderRadius.circular(20))),
 ),
 SizedBox(
 height: 5,
 ),
 TextField(
 controller: _emailIdControler,
 decoration: InputDecoration(
 labelText: 'Email Address',
 border: OutlineInputBorder(
 borderRadius: BorderRadius.circular(20))),
 ),
 SizedBox(
 height: 5,
 ),
 RaisedButton(
 color: Colors.red,
 child: (widget.modelPegawai.id != null)
 ? Text('Update',style: TextStyle(color:
Colors.white),)
 : Text('Add',style: TextStyle(color:
 Colors.white),),
 shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(20)),
 onPressed: () {
 if (widget.modelPegawai.id != null) {
 db
 .updatePegawai(ModelPegawai.fromMap({
 'id': widget.modelPegawai.id,
 'firstname': _firstNameControler.text,
 'lastname': _lastNameControler.text,
 'mobileno': _mobileNoControler.text,
 'emailid': _emailIdControler.text
 }))
 .then((_) {
 Navigator.pop(context, 'update');
 });
 } else {
 db
 .savePegawai(ModelPegawai(
 _firstNameControler.text,
 _lastNameControler.text,
 _mobileNoControler.text,
 _emailIdControler.text))
 .then((_) {
 Navigator.pop(context, 'save');
 });
 }
 })
 ],
 ),
 );
 }
}
