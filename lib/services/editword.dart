

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_new

import 'dart:io';

import 'package:church_windows/modal/formmodal.dart';
import 'package:docx_template/docx_template.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Createcertificate{


static Future<String>createBaptism(BuildContext context,BaptimsFormList baptisms) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
  final data = await rootBundle.load('assets/certificates/baptism.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);

  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Date",formatted))
    ..add(TextContent("Church", "Immaculate Conception Church Mananthavady"))
    ..add(TextContent("Refno", baptisms.refno))
    ..add(TextContent("Baptismnme", baptisms.baptismname))
    ..add(TextContent("Dob", baptisms.dob))
    ..add(TextContent("Dobaptism", baptisms.dobaptism))
    ..add(TextContent("Fsname", baptisms.fsrname))
    ..add(TextContent("Msname", baptisms.msname))
    ..add(TextContent("Adobebaptism", baptisms.abodebaptism))
    ..add(TextContent("Gfatheradobe", baptisms.gfatherabode))
    ..add(TextContent("Gmotherabode", baptisms.gmotherabode))
    ..add(TextContent("Ministerofbaptism", baptisms.ministerofbaptism));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}



static Future<String>createBanns(BuildContext context,Banns bannss) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
   final data = await rootBundle.load('assets/certificates/banns.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);

  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",bannss.groomname))
    ..add(TextContent("Groomhousename", bannss.groomhousename))
    ..add(TextContent("Groomparents", bannss.groomparents))
    ..add(TextContent("Groomparish", bannss.groomparish))
    ..add(TextContent("Groomdiocese", bannss.groomdiocese))
    ..add(TextContent("Bridename", bannss.bridename))
    ..add(TextContent("Bridehousename",bannss.bridehousename))
    ..add(TextContent("Brideparents",bannss.brideparents))
    ..add(TextContent("Brideparish", bannss.brideparish))
    ..add(TextContent("Bridediocese",bannss.bridediocese))
    ..add(TextContent("Groomname1",bannss.groomname))
    ..add(TextContent("Bridename1",bannss.bridename));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  // User canceled the picker
}
if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}

static Future<String>createMarriage(BuildContext context,Marriage marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);

   Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

   final data = await rootBundle.load('assets/certificates/marriage.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
   
  

  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomsonof", marriage.groomsonof))
    ..add(TextContent("Groombornon", marriage.groombornon))
    ..add(TextContent("Groombapt", marriage.groombapt))
    ..add(TextContent("Groomdatebapt", marriage.groomdatebapt))
    ..add(TextContent("Groomres", marriage.groomres))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Bridedaught", marriage.bridedaught))
    ..add(TextContent("Bridebornon", marriage.bridebornon))
    ..add(TextContent("Bridebapt", marriage.bridebapt))
    ..add(TextContent("Bridedatebapt", marriage.bridedatebapt))
    ..add(TextContent("Brideres", marriage.brideres))
    ..add(TextContent("Dateofmarriage", marriage.dateofmarriage))
    ..add(TextContent("Church", marriage.church))
    ..add(TextContent("Witness1", marriage.witness1))
    ..add(TextContent("Witness2", marriage.witness2))
    ..add(TextContent("Celebrant", marriage.celebrant))
    ..add(TextContent("Date", formatted))
    ..add(TextContent("Place", "Mananthavady"));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}



static Future<String>createMarriage3(BuildContext context,Marriage3 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage3.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);

  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomparents", marriage.groomparents))
    ..add(TextContent("Groombaptism", marriage.groombaptism+", "+marriage.groombaptismplace))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Brideparents", marriage.brideparents))
    ..add(TextContent("Bridebaptism", marriage.bridebaptism+", "+marriage.bridebaptismplace))
    ..add(TextContent("Noofbanns", marriage.noofbanns))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Place", "Mananthavady"))
    ..add(TextContent("Date", formatted));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}
static Future<String>createMarriage4(BuildContext context,Marriage4 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage4s.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
String groombapt="";
String bridebapt="";
if(marriage.bridebaptism==""&& marriage.bridebaptismplace==""){
  bridebapt="NA";
}
else{
  bridebapt=marriage.bridebaptism+", "+marriage.bridebaptismplace;
}

if(marriage.groombaptism==""&& marriage.groombaptismplace==""){
  groombapt="NA";
}
else{
  groombapt=marriage.groombaptism+", "+marriage.groombaptismplace;
}
  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomparents", marriage.groomparents))
    ..add(TextContent("Groombaptism", groombapt))
    ..add(TextContent("Groomreligion",marriage.groomreligion))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Brideparents", marriage.brideparents))
    ..add(TextContent("Bridebaptism", bridebapt))
    ..add(TextContent("Bridereligion",marriage.bridereligion))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Place", "Mananthavady"))
    ..add(TextContent("Date", formatted));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}

  
}


static Future<String>createMarriage5(BuildContext context,Marriage4 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage5.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
String groombapt="";
String bridebapt="";
if(marriage.bridebaptism==""&& marriage.bridebaptismplace==""){
  bridebapt="NA";
}
else{
  bridebapt=marriage.bridebaptism+", "+marriage.bridebaptismplace;
}

if(marriage.groombaptism==""&& marriage.groombaptismplace==""){
  groombapt="NA";
}
else{
  groombapt=marriage.groombaptism+", "+marriage.groombaptismplace;
}
  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomparents", marriage.groomparents))
    ..add(TextContent("Groombaptism", groombapt))
    ..add(TextContent("Groomreligion",marriage.groomreligion))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Brideparents", marriage.brideparents))
    ..add(TextContent("Bridebaptism", bridebapt))
    ..add(TextContent("Bridereligion",marriage.bridereligion))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Place", "Mananthavady"))
    ..add(TextContent("Date", formatted));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}

static Future<String>createMarriage6(BuildContext context,Marriage4 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage6.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
String groombapt="";
String bridebapt="";
if(marriage.bridebaptism==""&& marriage.bridebaptismplace==""){
  bridebapt="NA";
}
else{
  bridebapt=marriage.bridebaptism+", "+marriage.bridebaptismplace;
}

if(marriage.groombaptism==""&& marriage.groombaptismplace==""){
  groombapt="NA";
}
else{
  groombapt=marriage.groombaptism+", "+marriage.groombaptismplace;
}
  /* ds;
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomparents", marriage.groomparents))
    ..add(TextContent("Groombaptism", groombapt))
    ..add(TextContent("Groomreligion",marriage.groomreligion))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Brideparents", marriage.brideparents))
    ..add(TextContent("Bridebaptism", bridebapt))
    ..add(TextContent("Bridereligion",marriage.bridereligion))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Place", "Mananthavady"))
    ..add(TextContent("Date", formatted));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}

static Future<String>createMarriage7(BuildContext context,Marriage7 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage7i1.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
String? _catgender;
String? _noncatgender;
String? _noncatstatus;
  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx
  if(marriage.catholicgender=="Male"){
_catgender="son";
  }
  else if(marriage.catholicgender=="Female"){
_catgender="daughter";
  }

   if(marriage.noncatholicgender=="Male"){
_noncatgender="son";
  }
  else if(marriage.noncatholicgender=="Female"){
_noncatgender="daughter";
  }
  if(marriage.noncatholictype=="Non-Catholic"){
_noncatstatus="non-catholic (church: "+ marriage.noncatholicstatus+")";
  }
  else if(marriage.noncatholictype=="Non-Christian"){
_noncatstatus="non-christian (Religion and Cast: "+ marriage.noncatholicstatus+")";
  }

  Content c = Content();
 c..add(TextContent("Catholicname",marriage.catholicname))
    ..add(TextContent("Catholicgender", _catgender))
    ..add(TextContent("Catholicparents", marriage.catholicparents))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Noncatholicname",marriage.noncatholicname))
    ..add(TextContent("Noncatholicgender",_noncatgender))
    ..add(TextContent("Noncatholicparents", marriage.noncatholicparents))
    ..add(TextContent("Noncatholicstatus", _noncatstatus))
    ..add(TextContent("Noncatholicresiding",marriage.noncatholicresiding));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}

static Future<String>createMarriage8(BuildContext context,Marriage3 marriage) async{
Directory? rootPath;

  rootPath = await getTemporaryDirectory();
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);
    final data = await rootBundle.load('assets/certificates/marriage8.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);

  /* ds
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

  // Load test image for inserting in docx

  Content c = Content();
 c..add(TextContent("Groomname",marriage.groomname))
    ..add(TextContent("Groomparents", marriage.groomparents))
    ..add(TextContent("Groombaptism", marriage.groombaptism+", "+marriage.groombaptismplace))
    ..add(TextContent("Bridename",marriage.bridename))
    ..add(TextContent("Brideparents", marriage.brideparents))
    ..add(TextContent("Bridebaptism", marriage.bridebaptism+", "+marriage.bridebaptismplace))
    ..add(TextContent("Parish", "Immaculate Conception Church"))
    ..add(TextContent("Place", "Mananthavady"))
    ..add(TextContent("Date", formatted));

  final d = await docx.generate(c);

String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['docx'],
  fileName: formatted+'generated22.docx',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = File(outputFile);
  if (d != null) await of.writeAsBytes(d);
return "Success";
}
}
}