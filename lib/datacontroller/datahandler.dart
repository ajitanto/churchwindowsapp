// ignore_for_file: avoid_print, prefer_is_empty, unnecessary_brace_in_string_interps, unnecessary_null_comparison

import 'dart:io' as io;
import 'dart:async';





import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/modal/rentusercsv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart'
  show getApplicationDocumentsDirectory;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';




class DBProvider {
  // Singleton DatabaseHelper
  // Singleton Database

   Database? _db;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }


  // Create the database and the Employee table
  initDB() async {
    // ignore: unnecessary_null_comparison
    if (_db == null) {
      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();

     String path = join(documentsDirectory.path, "mydb.db");

     print(path);
print(path);
      // await deleteDatabase(path);


      
  var databaseFactory = databaseFactoryFfi;
  Database db = await databaseFactory.openDatabase(path);

 


      

    await db.execute(
        "CREATE TABLE IF NOT EXISTS rental_icc (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, rent_name TEXT NOT NULL, rent_namemalayalam TEXT NOT NULL, room_no TEXT NOT NULL,rent TEXT NOT NULL,building TEXT NOT NULL,phone TEXT NOT NULL,type TEXT NOT NULL,prev_due TEXT NOT NULL,status TEXT NOT NULL,rentstartedmonth TEXT NOT NULL,rentstartedyear TEXT NOT NULL,yearcycle TEXT NOT NULL)");
        await db.execute(
        "CREATE TABLE IF NOT EXISTS rental_month (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, rent_name TEXT,rent_namemalayalam TEXT NOT NULL, user_id TEXT NOT NULL,room_no TEXT NOT NULL,building TEXT NOT NULL,month TEXT NOT NULL,total_due TEXT NOT NULL,rentpayed TEXT NOT NULL,monthlyrent TEXT NOT NULL,rentperyear TEXT NOT NULL,year TEXT NOT NULL,prev_due TEXT NOT NULL,total_rentpayed TEXT NOT NULL,yearcycle TEXT NOT NULL)");
         await db.execute(
        "CREATE TABLE IF NOT EXISTS rental_log (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, rent_name TEXT NOT NULL,rent_namemalayalam TEXT NOT NULL, user_id TEXT NOT NULL,room_no TEXT NOT NULL,building TEXT NOT NULL,changed_month TEXT NOT NULL,changed_year TEXT NOT NULL,total_due TEXT NOT NULL,newmonthlyrent TEXT NOT NULL,oldmonthlyrent TEXT NOT NULL,yearcycle TEXT NOT NULL)");
      return db;
    }

    return db;
  }

  Future<String> createAuth(RentuserCsv rentcsv) async {
    final _db = await initDB();
 final DateTime now = DateTime.now();
 String flag="";
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
String yearcycle="";
    // final res = await db.insert('authUser', rentcsv.toJson());
if(int.parse(rentcsv.rentstartedmonth)>=4){

  yearcycle=int.parse(rentcsv.rentstartedyear).toString()+'-'+(int.parse(rentcsv.rentstartedyear)+1).toString();
}
else if(int.parse(rentcsv.rentstartedmonth)<=3){
 yearcycle=(int.parse(rentcsv.rentstartedyear)-1).toString()+'-'+int.parse(rentcsv.rentstartedyear).toString();
}
    var result = await _db.rawInsert(
        'INSERT INTO rental_icc (rent_name,rent_namemalayalam,room_no,rent,building,phone,type,prev_due,status,rentstartedmonth,rentstartedyear,yearcycle) VALUES ("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","${rentcsv.roomno}","${rentcsv.rent}","${rentcsv.building}","${rentcsv.phone}","${rentcsv.type}","${rentcsv.prevdue}","${rentcsv.status}","${rentcsv.rentstartedmonth}","${rentcsv.rentstartedyear}","'+yearcycle+'")');
    if (result > 0) {
var userdata=await _db.rawQuery('SELECT * from rental_icc ORDER BY id DESC LIMIT 1');

if (userdata.length > 0) {    
     for (int i = 0; i < userdata.length; i++) { 
if(int.parse(userdata[i]["rentstartedmonth"])>=4){
  yearcycle=int.parse(userdata[i]["rentstartedyear"]).toString()+"-"+(int.parse(userdata[i]["rentstartedyear"])+1).toString();
}
else if(int.parse(userdata[i]["rentstartedmonth"])<=3){
   yearcycle=(int.parse(userdata[i]["rentstartedyear"])-1).toString()+"-"+int.parse(userdata[i]["rentstartedyear"]).toString();
}

      final result1 = await _db.rawInsert(
        'INSERT INTO rental_log (rent_name,rent_namemalayalam,user_id,room_no,building,changed_month,changed_year,total_due,newmonthlyrent,oldmonthlyrent,yearcycle) VALUES' 
   '("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","${userdata[i]["id"]}","${rentcsv.roomno}","${rentcsv.building}","${rentcsv.rentstartedmonth}","${rentcsv.rentstartedyear}","${rentcsv.prevdue}","${rentcsv.rent}","${rentcsv.rent}","${yearcycle}")');
     
     if(result1>0){
flag+=rentcsv.rentname+" with Room number"+rentcsv.roomno+" has been added Successfully!";
     }
     else{
   flag+=" Somthing went wrong";
     }
     
     }
     
}else{
  flag+=" Somthing went wrong";
}

    
    } else {
      flag+=" Somthing went wrong";
    }
    
    return flag;

    // return res;
  }


  Future<bool> loginstatusarg(String nameeng,String roomno,String building,String rent,String status,String rentstartmonth,String rentstartyear) async{

  final _db = await initDB();
var result = await _db.rawQuery(
    'SELECT * FROM rental_icc WHERE rent_name=? and room_no=? and building=? and rent=? and status=? and rentstartedmonth=? and rentstartedyear=?', 
    [nameeng, roomno,building,rent,status,rentstartmonth,rentstartyear]
);
return  result.length>0 ? true :false;

  }



  Future<bool> isavailrentuser(String yearcycle) async{

  final _db = await initDB();
var result = await _db.rawQuery(
    'SELECT * FROM rental_month WHERE yearcycle? ', 
    [yearcycle]
);
return  result.length>0 ? true :false;

  }


Future<List<RentMonth>> getAllRent(String yearcycle) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();
print(yearcycle);
String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
    List<RentMonth> _rentusercsv = [];

    var map=await _db.rawQuery("SELECT * from rental_icc where  yearcycle=?",
    [yearcycle]);
    if(map.length>0){
      for(int i=0;i<map.length;i++){
        print("hiii" +map.length.toString());
  var res = await _db.rawQuery('SELECT * from rental_month where yearcycle=? and user_id=? order by id desc limit 1',
  [yearcycle,map[i]['id'].toString()]);
// Get first result

    if (res.length > 0) {
      for (int j = 0; j < res.length; j++) {
        _rentusercsv.add(RentMonth.fromMapObject(res[j]));
      }
      
    }
    }
    return _rentusercsv;
    }
   return _rentusercsv;    
 }    



 Future<String> transferRenttable() async {    
final _db = await initDB();  

int year;
int m;
int j;
int mnow;
int endmonth;
bool isrentmonth;
int count1=1;
int count=1;
String yearcycle="";
 final DateTime now = DateTime.now();

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);
  var maps = await _db.query("rental_icc");  
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {    
      // _rentusercsv.add(RentuserCsv.fromMapObject(maps[i]));   
      rentuser=RentuserCsv.fromMapObject(maps[i]);
      
      m=int.parse(rentuser.rentstartedmonth);

      mnow=int.parse(monthnow);
     
if(m>=4){
  
yearcycle=int.parse(yearnow).toString()+"-"+(int.parse(yearnow)+1).toString();
  for(int i=m;i<=12;i++){

 
   
     
 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
            
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,i.toString(),yearcycle);
              } 
             
  }
  for(int j=1;j<=3;j++){


 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,j.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
             
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,j.toString(),yearcycle);
              } 

  }



}


else if(m<=3){
  yearcycle=(int.parse(yearnow)-1).toString()+"-."+int.parse(yearnow).toString();
  int dif=int.parse(rentuser.rentstartedmonth)+11;
  for(int i=m;i<=3;i++){


    year=int.parse(rentuser.rentstartedyear)+1;
isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),yearnow);
  
   if (isrentmonth) {
      
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,i.toString(),yearcycle);
              }  
count++;
  }
}
     }    
     return "Success";
   }
   else{    
   return "Error";    
   }
 }    


  Future<int> createRentlist(RentuserCsv rentcsv, String year,String month,String yearcycle) async {
    final _db = await initDB();
    
   int rentyear=   int.parse(rentcsv.rent)*12;
    // final res = await db.insert('authUser', rentcsv.toJson());
    final result = await _db.rawInsert(
   
        'INSERT INTO rental_month (rent_name,rent_namemalayalam,user_id,room_no,building,month,total_due,rentpayed,monthlyrent,rentperyear,year,prev_due,total_rentpayed,yearcycle) VALUES ("'+rentcsv.rentname+'","'+rentcsv.rentnamemalayalam+'","'+rentcsv.id.toString()+'","'+rentcsv.roomno+'","'+rentcsv.building+'","'+month+'","'+rentcsv.prevdue+'","0","'+rentcsv.rent+'","'+rentyear.toString()+'","'+year+'","'+rentcsv.prevdue+'","0","'+yearcycle+'")');
    if (result > 0) {
  

    
    } else {
    
    }
    return result;

    // return res;
  }


    Future<bool> rentmontharg(String nameeng,String roomno,String building,String rent,String rentstartedmonth,String rentstartedyear) async{

  final _db = await initDB();
List<Map> result = await _db.rawQuery(
    'SELECT * FROM rental_month WHERE rent_name=? and room_no=? and building=? and monthlyrent=? and year=? and month=?', 
    [nameeng, roomno,building,rent,rentstartedyear,rentstartedmonth]
);
return  result.length>0 ? true :false;

  }
  
     Future<String> rentperyear1(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
int count1=1;
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where  yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];



yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4 ){



totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3){

totalre+=int.parse(map[k]['monthlyrent']);

  }


}

    }

    }


  
     return totalre.toString();
   }
   else{
return "0";
   }
  }
     Future<String> rentperyear2(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
int count1=1;
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where  yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];



yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){






totalre+=int.parse(map[k]['monthlyrent']);




  


}

    }

    }


  
     return totalre.toString();
   }
   else{
return "0";
   }
  }

   Future<String> rentrentrecieved1(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];




  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4){

// if(int.parse(map[k]["month"])>int.parse(month)){
//   totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["rentpayed"]);
// }
totalre+=int.parse(map[k]['rentpayed']);


  }
  else if(int.parse(map[k]["month"])<=3){


// if(int.parse(map[k]["month"])<int.parse(month)){
//   totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["rentpayed"]);
// }
totalre+=int.parse(map[k]['rentpayed']);

  }


}

    }
    
  
    }



     return totalre.toString();
   }
   else{
return "error";
   }
  }
 Future<String> rentrentrecieved2(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where  yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];




  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){




// if(int.parse(map[k]["month"])>int.parse(month)){
//   totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["rentpayed"]);
// }
totalre+=int.parse(map[k]['rentpayed']);





// if(int.parse(map[k]["month"])<int.parse(month)){
//   totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["rentpayed"]);
// }





}

    }
    
  
    }



     return totalre.toString();
   }
   else{
return "0";
   }
  }


 Future<String> lastmonthuser(String userid,String yearcycle) async{
String total="";
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_month where user_id=? and yearcycle=? ORDER BY id DESC limit 1', 
     [userid,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
 if(int.parse(maps[0]['month'])>=4){

total= maps[0]['month']+'/'+maps[0]['year'];
 }
 else if(int.parse(maps[0]['month'])<=4){

total=maps[0]['month']+'/'+(int.parse(maps[0]['year'])+1).toString();

 }
 
     




    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    

   
   }
  
   return total;
  
  }

Future<List<String>> yearcycleList() async{
List<String> total=[];
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
var maps = await _db.rawQuery(
    'SELECT DISTINCT yearcycle FROM rental_month'
);
if(maps.length>0){
int i=0;
do{
total.add(maps[i]['yearcycle']);
i++;
}while(i<maps.length);


  
}
  
   return total;
  
  }



  Future<String> renttotalmonth(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
  'SELECT * FROM rental_icc where  yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

    if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and yearcycle=?', 
    [id,month,4,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){

totalre+=int.parse(map[k]['monthlyrent']);

}
  
    }
    }
    else if(int.parse(month)<=3){
    int mon=int.parse(month);
    int j;
  
var maps=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id ASC limit 1',
    [id,yearcycle] );
if(maps.length>0){
j=13+mon-int.parse(maps[0]["month"]);
var map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id asc limit '+j.toString()+'', 
    [id,yearcycle]);
    if(map.length>0){
   
for(int k=0;k<map.length;k++){
  
 totalre+=int.parse(map[k]['rentpayed']);

}
    }
}
    }
    }

     return totalre.toString();
   }
   else{
return "error";
   }
  }

  Future<String> renttotalmonth1(String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where  yearcycle=?', 
     [yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

  

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){

totalre+=int.parse(map[k]['monthlyrent']);

}
  
    }
    
   
    }

     return totalre.toString();
   }
   else{
return "error";
   }
  }


 

 Future<String> rentperyearusers(String user_id,String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [user_id,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

 
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4){



totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3){



totalre+=int.parse(map[k]['monthlyrent']);

  }


}

    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    

    
    }

     return totalre.toString();
   }
   else{
return 0.toString();
   }
  }

 Future<String> rentperyearusers1(String user_id,String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
     'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [user_id,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

 
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4){



totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3){



totalre+=int.parse(map[k]['monthlyrent']);

  }


}

    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    

    
    }

     return totalre.toString();
   }
   else{
return 0.toString();
   }
  }




//   Future<String> rentperyearuser(String user_id) async{
// String total;
// int totalre=0;
// int yearnew=0;
// int yearold=0;
// int totaldue=0;
//  final DateTime now = DateTime.now();

// String month=DateFormat.M().format(now);
// String year=DateFormat.y().format(now);
//   final _db = await initDB();
// List<Map> maps = await _db.rawQuery(
//     'SELECT * FROM rental_icc where id=?  and status=?', 
//      [user_id,"active"]
// );
//   RentuserCsv? rentuser;  

//    if (maps.length > 0) {    
//      for (int i = 0; i < maps.length; i++) {   
//       int id=maps[i]['id'];

//     if(int.parse(month)>=4){

// yearnew=int.parse(year)+1;
// yearold=int.parse(year);
//   List<Map> map=await _db.rawQuery(
//     'SELECT * FROM rental_month WHERE user_id=? and ( year>=? or year <=?)', 
//     [id,yearold,yearnew]);
//     if(map.length>0){
// for(int k=0;k<map.length;k++){


//   if(int.parse(map[k]["month"])>=4  && int.parse(map[k]["year"])==yearold){

// print(map[k]["month"]+"new");
// if(int.parse(map[k]["month"])>int.parse(month)){
//   totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
// }
// totalre+=int.parse(map[k]['monthlyrent']);


//   }
//   else if(int.parse(map[k]["month"])<=3 &&  int.parse(map[k]["year"])==yearnew){


// print(map[k]["month"]+"new");
// if(int.parse(map[k]["month"])<int.parse(month)){
//   totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
// }
// totalre+=int.parse(map[k]['monthlyrent']);

//   }


// }

//     // for (int j = 0; j < map.length; j++) {   

//     //  List<Map> mapchange=await _db.rawQuery(
//     // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
//     // [int.parse(maps[i]['id'])]);
//     // if(mapchange.length>1){


//     // }

//     // }



// // totalre+=int.parse(maps[i]['rentperyear']);
//     }
//     }
//     else if(int.parse(month)<=3){

//      yearnew=int.parse(year);
// yearold=int.parse(year)-1;
//   List<Map> map=await _db.rawQuery(
//     'SELECT * FROM rental_month WHERE user_id=? and ( year>=? or year <=?)', 
//     [id,yearold,yearnew]);
//     if(map.length>0){
// for(int k=0;k<map.length;k++){
//   if(int.parse(map[k]["month"])>=4 && int.parse(map[k]["year"])==yearold){

// print(map[k]["month"]+"new");
// if(int.parse(map[k]["month"])>int.parse(month)){
//   totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
// }
// totalre+=int.parse(map[k]['monthlyrent']);


//   }
//   else if(int.parse(map[k]["month"])<=3 && int.parse(map[k]["year"])==yearnew){


// print(map[k]["month"]+"new");
// if(int.parse(map[k]["month"])<int.parse(month)){
//   totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
// }
// totalre+=int.parse(map[k]['monthlyrent']);

//   }

// }
//     }
    
//     }
//     }

//      return totalre.toString();
//    }
//    else{
// return "error";
//    }
//   }
 

 Future<List<RentMonth>> getAllDet(String userid,String yearcycle) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
    List<RentMonth> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_month where user_id=?  and yearcycle=? ORDER BY id DESC LIMIT 1',
  [userid,yearcycle]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        _rentusercsv.add(RentMonth.fromMapObject(res[i]));
      }
      return _rentusercsv;
    }
   return _rentusercsv;    
 }    

Future<List<RentuserCsv>> getAllDeticc(String userid) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
    List<RentuserCsv> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_icc where id=? and status=?',
  [userid,"active"]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        _rentusercsv.add(RentuserCsv.fromMapObject(res[i]));
      }
      return _rentusercsv;
    }
   return _rentusercsv;    
 }    


 Future<String> rentpaymonths(String month,String year,String userid) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();
String rent="";
    List<RentMonth> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_month where user_id=? and month=? and year=?',
  [userid,month,year]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
       rent=res[i]['rentpayed'];
      }
      return rent;
    }
   return rent;    
 }    



   Future<String> renttotaldueuser(String usercode) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and status=?', 
     [usercode,"active"]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

  if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and ( year>=? or year <=?)', 
    [id,yearold,yearnew]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4  && int.parse(map[k]["year"])==yearold){


if(map[k]["month"]==month){
  totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
}
totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3 &&  int.parse(map[k]["year"])==yearnew){



if(map[k]["month"]==month){
  totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
}
totalre+=int.parse(map[k]['monthlyrent']);

  }


}

    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    }
    else if(int.parse(month)<=3){

     yearnew=int.parse(year);
yearold=int.parse(year)-1;
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and ( year>=? or year <=?)', 
    [id,yearold,yearnew]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  if(int.parse(map[k]["month"])>=4 && int.parse(map[k]["year"])==yearold){

if(map[k]["month"]==month){
  totalre+=(15-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
}
totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3 && int.parse(map[k]["year"])==yearnew){


if(map[k]["month"]==month){
  totalre+=(12-int.parse(map[k]["month"]))*int.parse(map[k]["monthlyrent"]);
}
totalre+=int.parse(map[k]['monthlyrent']);

  }

}
    }
    
    }
    }

     return totalre.toString();
   }
   else{
return "error";
   }
  }
 
Future<String> renttotaldueusers(String usercode,String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
int totaldue=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
  'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [usercode,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

  

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [id,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){


  if(int.parse(map[k]["month"])>=4 ){



totalre+=int.parse(map[k]['monthlyrent']);


  }
  else if(int.parse(map[k]["month"])<=3 ){




totalre+=int.parse(map[k]['monthlyrent']);

  }



    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }

  
    }
    }

     return totalre.toString();
   }
   else{
return "error";
   }
  }
 


 Future<String> rentpayedusers(String usercode, String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [usercode,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

    if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and yearcycle=?', 
    [usercode,month,4,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['rentpayed']);

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    }
    else if(int.parse(month)<=3){
    int mon=int.parse(month);
    int j;
  
var maps=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id ASC limit 1',
    [usercode,yearcycle] );
if(maps.length>0){
j=13+mon-int.parse(maps[0]["month"]);
var map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id asc limit '+j.toString()+'', 
    [usercode,yearcycle]);
    if(map.length>0){
    
for(int k=0;k<map.length;k++){
  
 totalre+=int.parse(map[k]['rentpayed']);

}
    }
}
    }
    }



     return totalre.toString();
   }
   else{
return "error";
   }
  }


 Future<String> rentpayedusers1(String usercode, String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [usercode,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

   
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=?', 
    [usercode,month,4,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['rentpayed']);

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    
  
    }



     return totalre.toString();
   }
   else{
return "0";
   }
  }



 Future<String> rentneedtopayusers(String usercode, String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
  'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [usercode,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

    if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and yearcycle=?', 
    [usercode,month,4,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['monthlyrent']);

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    }
     else if(int.parse(month)<=3){
    int mon=int.parse(month);
    int j;
  
var maps=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id ASC limit 1',
    [usercode,yearcycle] );
if(maps.length>0){
j=13+mon-int.parse(maps[0]["month"]);
var map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id asc limit '+j.toString()+'', 
    [usercode,yearcycle]);
    if(map.length>0){

for(int k=0;k<map.length;k++){
  
 totalre+=int.parse(map[k]['monthlyrent']);

}
    }
}
    }
    }



     return totalre.toString();
   }
   else{
return "0";
   }
  }

 Future<String> rentneedtopayusers1(String usercode, String yearcycle) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
   'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [usercode,yearcycle]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

 

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=?  and yearcycle=?', 
    [usercode,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['monthlyrent']);

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    

    }



     return totalre.toString();
   }
   else{
return "0";
   }
  }

 Future<String> rentpayeduser(String usercode) async{
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and status=?', 
     [usercode,"active"]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

    if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and ( year>=? or year <=?)', 
    [usercode,month,4,yearold,yearnew]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['rentpayed']);

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    }
    else if(int.parse(month)<=3){

     yearnew=int.parse(year);
yearold=int.parse(year)-1;
  List<Map> map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and ( year>=? or year <=?)', 
    [usercode,month,1,yearold,yearnew]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
totalre+=int.parse(map[k]['rentpayed']);

}
    }
    }
    }


  
     return totalre.toString();
   }
   else{
return "error";
   }
  }


Future<String> addedmonth(String usercode) async{

  String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();

List<Map> maps = await _db.rawQuery(
    'SELECT * FROM rental_icc where id=? and status=?', 
     [usercode,"active"]
);
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
if(int.parse(year)==int.parse(maps[i]["rentstartedyear"])){

  if(int.parse(maps[i]["rentstartedmonth"])>=4  && int.parse(month)>=4){

 totalre=int.parse(maps[i]['rentstartedmonth']);

  }
  else if(int.parse(maps[i]["rentstartedmonth"])<=3 && int.parse(month)<=4){

totalre=maps[i]['rentstartedmonth'];

  }

}
else {


totalre=4;

}
//       if(int.parse(month)>=4){
// List<Map> map = await _db.rawQuery(
//     'SELECT * FROM rental_month where id=? and year=? and month>=4 order by id asc limit 1', 
//      [usercode,year]
// );

//  for (int j = 0; j < map.length; j++) {   

//   totalre=int.parse(map[j]["month"]);
//       }
//        }
//        else if(int.parse(month)<=3){

// List<Map> map = await _db.rawQuery(
//     'SELECT * FROM rental_month where id=? and year=? and month>=4 order by id asc limit 1', 
//      [usercode,year]
// );


//        }
    

     }
  
     return totalre.toString();
   }
   else{
return "error";
   }
}


Future<List<RentMonth>> getAllDetwith(String userid,String yearcycle) async {  
String total;
int totalre=0;
int yearnew=0;
int yearold=0;
 final DateTime now = DateTime.now();

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
  final _db = await initDB();
List<Map> maps = await _db.rawQuery(
     'SELECT * FROM rental_icc where id=? and yearcycle=? ', 
     [userid,yearcycle]
);
  RentuserCsv? rentuser;  
  List<RentMonth> _rentusercsv = [];
   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {   
      int id=maps[i]['id'];

    if(int.parse(month)>=4){

yearnew=int.parse(year)+1;
yearold=int.parse(year);
 var map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and (month<=? and month>=?) and yearcycle=?', 
    [userid,month,4,yearcycle]);
    if(map.length>0){
for(int k=0;k<map.length;k++){
  
 _rentusercsv.add(RentMonth.fromMapObject(map[k]));

}
    // for (int j = 0; j < map.length; j++) {   

    //  List<Map> mapchange=await _db.rawQuery(
    // 'SELECT * FROM rental_changelog WHERE user_id=? ORDER BY DESC', 
    // [int.parse(maps[i]['id'])]);
    // if(mapchange.length>1){


    // }

    // }



// totalre+=int.parse(maps[i]['rentperyear']);
    }
    }
    else if(int.parse(month)<=3){
    int mon=int.parse(month);
    int j;
  
var maps=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id ASC limit 1',
    [userid,yearcycle] );
if(maps.length>0){
j=13+mon-int.parse(maps[0]["month"]);
var map=await _db.rawQuery(
    'SELECT * FROM rental_month WHERE user_id=? and yearcycle=? order by id asc limit '+j.toString()+'', 
    [userid,yearcycle]);
    if(map.length>0){
      
for(int k=0;k<map.length;k++){
  
 _rentusercsv.add(RentMonth.fromMapObject(map[k]));

}
    }
}
    }
    }


   
     return  _rentusercsv;
   }
   else{
return  _rentusercsv;
   }
    }
  
  Future<bool> addRent(Addrent addrent) async {
   final _db = await initDB();  

      List<Map> resultuser = await _db.rawQuery(
    'SELECT * FROM rental_icc WHERE  id=?', 
    [addrent.userid]
);
if(resultuser.length>0){
 final res = await _db.rawUpdate("update rental_month set rentpayed='" +
        addrent.rent +
        "' where year='" +
        addrent.year +
        "' and month='" +
        addrent.month +
        "' and user_id='" +
        addrent.userid +
        "'");
        if(res>0){
       
              return true;
        }
        else{
          return false;
        }

}
else{

  return false;
}
  }


   Future<bool> editRentuser(Editrentuser editrentuser) async {
   final _db = await initDB();  

      List<Map> resultuser = await _db.rawQuery(
    'SELECT * FROM rental_icc WHERE  id=?', 
    [editrentuser.userid]
);
if(resultuser.length>0){
 final res = await _db.rawUpdate("update rental_month set rent_name='" +
        editrentuser.rentname +
        "', rent_namemalayalam='"+editrentuser.rentnamemalayalam+"',room_no='"+editrentuser.room+"', building='"+editrentuser.building+"' where user_id='" +
        editrentuser.userid +
        "' ");
        if(res>0){
       final res1 = await _db.rawUpdate("update rental_icc set rent_name='" +
        editrentuser.rentname +
        "', rent_namemalayalam='"+editrentuser.rentnamemalayalam+"',room_no='"+editrentuser.room+"', building='"+editrentuser.building+"',phone='"+editrentuser.phone+"' where id='" +
        editrentuser.userid +
        "' ");
        if(res1>0){
 final res2 = await _db.rawUpdate("update rental_log set rent_name='" +
        editrentuser.rentname +
        "', rent_namemalayalam='"+editrentuser.rentnamemalayalam+"',room_no='"+editrentuser.room+"', building='"+editrentuser.building+"' where user_id='" +
        editrentuser.userid +
        "' ");
        if(res2>0){
return true;
        }
        else{
          return false;
        }
        }
        else{
          return false;
        }
        }
        else{
          return false;
        }

}
else{

  return false;
}
  }

 Future<String> addnewRentuser(RentuserCsv rentcsv) async {
    final _db = await initDB();
 final DateTime now = DateTime.now();
 String flag="";


String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
String yearcycle="";
    // final res = await db.insert('authUser', rentcsv.toJson());
if(int.parse(rentcsv.rentstartedmonth)>=4){

  yearcycle=int.parse(rentcsv.rentstartedyear).toString()+'-'+(int.parse(rentcsv.rentstartedyear)+1).toString();
}
else if(int.parse(rentcsv.rentstartedmonth)<=3){
 yearcycle=(int.parse(rentcsv.rentstartedyear)-1).toString()+'-'+int.parse(rentcsv.rentstartedyear).toString();
}

    var result = await _db.rawInsert(
        'INSERT INTO rental_icc (rent_name,rent_namemalayalam,room_no,rent,building,phone,type,prev_due,status,rentstartedmonth,rentstartedyear,yearcycle) VALUES ("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","${rentcsv.roomno}","${rentcsv.rent}","${rentcsv.building}","${rentcsv.phone}","${rentcsv.type}","${rentcsv.prevdue}","active","${rentcsv.rentstartedmonth}","${rentcsv.rentstartedyear}","'+yearcycle+'")');
    if (result > 0) {
var userdata=await _db.rawQuery('SELECT * from rental_icc ORDER BY id DESC LIMIT 1');

if (userdata.length > 0) {    

     for (int i = 0; i < userdata.length; i++) { 
if(int.parse(rentcsv.rentstartedmonth)>=4){
  yearcycle=int.parse(rentcsv.rentstartedyear).toString()+"-"+(int.parse(rentcsv.rentstartedyear)+1).toString();
}
else if(int.parse(rentcsv.rentstartedmonth)<=3){
   yearcycle=(int.parse(rentcsv.rentstartedyear)-1).toString()+"-"+int.parse(rentcsv.rentstartedyear).toString();
}

      final result1 = await _db.rawInsert(
        'INSERT INTO rental_log (rent_name,rent_namemalayalam,user_id,room_no,building,changed_month,changed_year,total_due,newmonthlyrent,oldmonthlyrent,yearcycle) VALUES' 
   '("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","'+userdata[i]["id"].toString()+'","${rentcsv.roomno}","${rentcsv.building}","${rentcsv.rentstartedmonth}","${rentcsv.rentstartedyear}","${rentcsv.prevdue}","${rentcsv.rent}","${rentcsv.rent}","'+yearcycle+'")');
     
     if(result1>0){
      
flag+=rentcsv.rentname+" with Room number"+rentcsv.roomno+" has been added Successfully!";

DBProvider.db.transferRenttable2(userdata[i]["id"].toString());
flag="Success";

     }
     else{
   flag+=" Somthing went wrong";
     }
     
     }
     
}else{
  flag+=" Somthing went wrong";
}

    
    } else {
      flag+=" Somthing went wrong";
    }
    
    return flag;

    // return res;
  }


Future<String> transferRenttable2(String userid) async {    
final _db = await initDB();  

int year;
int m;
int j;
int mnow;
int endmonth;
bool isrentmonth;
int count1=1;
int count=1;
String yearcycle="";
 final DateTime now = DateTime.now();

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);

var maps=await _db.rawQuery('SELECT * from rental_icc where id=?',
[userid]); 
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {  
    
   rentuser=RentuserCsv.fromMapObject(maps[i]);
      
      m=int.parse(rentuser.rentstartedmonth);

      mnow=int.parse(monthnow);
     
if(m>=4){
  
yearcycle=int.parse(yearnow).toString()+"-"+(int.parse(yearnow)+1).toString();
  for(int i=m;i<=12;i++){

 
   
     
 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
              
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,i.toString(),yearcycle);
              } 
             
  }
  for(int j=1;j<=3;j++){


 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,j.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
            
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,j.toString(),yearcycle);
              } 

  }



}




else if(m<=3){
  yearcycle=(int.parse(rentuser.rentstartedyear)-1).toString()+"-."+int.parse(rentuser.rentstartedyear).toString();
  int dif=int.parse(rentuser.rentstartedmonth)+11;
  for(int i=m;i<=3;i++){


    year=int.parse(rentuser.rentstartedyear)+1;
isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),yearnow);
  
   if (isrentmonth) {
            
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearnow,i.toString(),yearcycle);
              }  
count++;
  }
}
     }
   }
     return "Success";
   
 
   }


  Future<String> createnewyearcycle(String yearcycle) async {
final _db = await initDB();
 final DateTime now = DateTime.now();
 String flag="";
String yearcycle1="";
String yearstart="";

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
 RentuserCsv? rentuser;  

var maps=await _db.rawQuery('SELECT * from rental_icc where yearcycle=?',
[yearcycle]); 
 
   if (maps.length > 0) {    
    if(int.parse(month)>=4){
      yearcycle1=(int.parse(year)+1).toString()+'-'+(int.parse(year)+2).toString();
    }
    else if(int.parse(month)<=3){
      yearcycle1=int.parse(year).toString()+'-'+(int.parse(year)+1).toString();
    }
 final split = yearcycle1.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[0].toString();
     for (int i = 0; i < maps.length; i++) { 
rentuser=RentuserCsv.fromMapObject(maps[i]);
 var isLoggedIn = await DBProvider.db.loginstatusarg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,rentuser.status,'4',yearstart);
              if (isLoggedIn) {
                print('already added');
              }
              else{
var map=await _db.rawQuery('SELECT * from rental_log where yearcycle=? and user_id=? ORDER BY id DESC LIMIT 1',
[yearcycle,maps[i]['id'].toString()]); 
 
   if (map.length > 0) {   

DBProvider.db.createAuthnew(rentuser,yearcycle1,map[0]['newmonthlyrent']);

   }
}
     }
DBProvider.db.transferRenttable3(yearcycle1);
     }else{

 if(int.parse(month)>=4){
      yearcycle1=(int.parse(year)-1).toString()+'-'+int.parse(year).toString();
    }
    else if(int.parse(month)<=3){
      yearcycle1=(int.parse(year)-2).toString()+'-'+(int.parse(year)-1).toString();
    }

var maps=await _db.rawQuery('SELECT * from rental_icc where yearcycle=?',
[yearcycle1]); 
  RentuserCsv? rentuser;  

   if (maps.length > 0) {  
   if(int.parse(month)>=4){
      yearcycle1=int.parse(year).toString()+'-'+(int.parse(year)+1).toString();
    }
    else if(int.parse(month)<=3){
      yearcycle1=(int.parse(year)-1).toString()+'-'+int.parse(year).toString();
    }

     final split = yearcycle1.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[0].toString();
     for (int i = 0; i < maps.length; i++) { 
rentuser=RentuserCsv.fromMapObject(maps[i]);
 var isLoggedIn = await DBProvider.db.loginstatusarg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,rentuser.status,'4',yearstart);
              if (isLoggedIn) {
                print('already added');
              }
              else{
                var map=await _db.rawQuery('SELECT * from rental_log where yearcycle=? and user_id=? ORDER BY id DESC LIMIT 1',
[yearcycle,maps[i]['id'].toString()]); 
 
   if (map.length > 0) {   

DBProvider.db.createAuthnew(rentuser,yearcycle1,map[0]['newmonthlyrent']);

   }
}
     }
DBProvider.db.transferRenttable3(yearcycle1);
   }

     }
    return "success";
  }
   
     Future<String> createAuthnew(RentuserCsv rentcsv,String yearcycle,String newrent) async {
    final _db = await initDB();
 final DateTime now = DateTime.now();
 String flag="";
 String yearstart;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final formatted = formatter.format(now);

String month=DateFormat.M().format(now);
String year=DateFormat.y().format(now);
 final split = yearcycle.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[0].toString();
    
    // final res = await db.insert('authUser', rentcsv.toJson());

      var result = await _db.rawInsert(
        'INSERT INTO rental_icc (rent_name,rent_namemalayalam,room_no,rent,building,phone,type,prev_due,status,rentstartedmonth,rentstartedyear,yearcycle) VALUES ("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","${rentcsv.roomno}","'+newrent+'","${rentcsv.building}","${rentcsv.phone}","${rentcsv.type}","${rentcsv.prevdue}","${rentcsv.status}","${rentcsv.rentstartedmonth}","'+yearstart+'","'+yearcycle+'")');
    if (result > 0) {



      final result1 = await _db.rawInsert(
        'INSERT INTO rental_log (rent_name,rent_namemalayalam,user_id,room_no,building,changed_month,changed_year,total_due,newmonthlyrent,oldmonthlyrent,yearcycle) VALUES' 
   '("${rentcsv.rentname}","${rentcsv.rentnamemalayalam}","${result}","${rentcsv.roomno}","${rentcsv.building}","${rentcsv.rentstartedmonth}","'+yearstart+'","${rentcsv.prevdue}","'+newrent+'","'+newrent+'","${yearcycle}")');
     
     if(result1>0){
flag="Success";
     }
     else{
   flag+=" Somthing went wrong";
     }
     
     
     


    
    } else {
      flag+=" Somthing went wrong";
    }
    
    return flag;

    // return res;
  }

Future<String> transferRenttable3(String yearcycle) async {    
final _db = await initDB();  

int year;
int m;
int j;
int mnow;
int endmonth;
bool isrentmonth;
int count1=1;
int count=1;
String yearstart;

 final DateTime now = DateTime.now();

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);

var maps=await _db.rawQuery('SELECT * from rental_icc where status=? and yearcycle=? order by id asc',
['active',yearcycle]); 
  RentuserCsv? rentuser;  

   if (maps.length > 0) {    
     for (int i = 0; i < maps.length; i++) {  
    
   rentuser=RentuserCsv.fromMapObject(maps[i]);
      
      m=int.parse(rentuser.rentstartedmonth);

      mnow=int.parse(monthnow);
     
if(m>=4){
  

  for(int i=m;i<=12;i++){

 final split = yearcycle.split('-');
final Map<int, String> values = {
  for (int k = 0; k < split.length; k++)
   k: split[k]
};
    yearstart=values[0].toString();
   
     
 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
              
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearstart,i.toString(),yearcycle);
              } 
             
  }
  for(int j=1;j<=3;j++){
final split = yearcycle.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[1].toString();
   

 isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,j.toString(),rentuser.rentstartedyear);    
        if (isrentmonth) {
            
              }
              else{
              
            DBProvider.db.createRentlist(rentuser,yearstart,j.toString(),yearcycle);
              } 

  }



}




// else if(m<=3){
//   yearcycle=(int.parse(rentuser.rentstartedyear)-1).toString()+"-."+int.parse(rentuser.rentstartedyear).toString();
//   int dif=int.parse(rentuser.rentstartedmonth)+11;
//   for(int i=m;i<=3;i++){


//     year=int.parse(rentuser.rentstartedyear)+1;
// isrentmonth = await DBProvider.db.rentmontharg(rentuser.rentname,rentuser.roomno,rentuser.building,rentuser.rent,i.toString(),yearnow);
  
//    if (isrentmonth) {
            
//               }
//               else{
              
//             DBProvider.db.createRentlist(rentuser,yearnow,i.toString(),yearcycle);
//               }  
// count++;
//   }
// }
     }
   }
     return "Success";
   
 
   }

Future <bool> updateRent(Addrent addrent) async
{
String yearstart="";
  final _db = await initDB();
bool flag=false;
var maps=await _db.rawQuery('SELECT * from rental_month where id=? and  yearcycle=? LIMIT 1',
[addrent.userid,addrent.year]
);
if(maps.length>0){
print(maps[0]['user_id']+"hiii");
var map=await _db.rawQuery('SELECT * from rental_icc where status=? and id=? and  yearcycle=? LIMIT 1',
['active',int.parse(maps[0]['user_id']),addrent.year]
);
if(map.length>0){
if(int.parse(addrent.month)>=4){
   final split = addrent.year.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[0].toString();
}
else if(int.parse(addrent.month)<=3){
    final split = addrent.year.split('-');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    yearstart=values[1].toString();
}
final result1 = await _db.rawInsert(
        'INSERT INTO rental_log (rent_name,rent_namemalayalam,user_id,room_no,building,changed_month,changed_year,total_due,newmonthlyrent,oldmonthlyrent,yearcycle) VALUES' 
   '("'+map[0]['rent_name']+'","'+map[0]['rent_namemalayalam']+'","'+map[0]["id"].toString()+'","'+map[0]["room_no"]+'","'+map[0]["building"]+'","'+addrent.month+'","'+yearstart+'","'+map[0]['prev_due']+'","'+addrent.rent+'","'+map[0]['rent']+'","'+addrent.year+'")');
     
     if(result1>0){
if(int.parse(addrent.month)>=4){
  for(int i=int.parse(addrent.month);i<=12;i++){
final res = await _db.rawUpdate("update rental_month set monthlyrent='" +
        addrent.rent +
        "' where yearcycle='" +
        addrent.year +
        "' and month='" +
        i.toString() +
        "' and user_id='" +
        addrent.userid +
        "'");
        if(res>0){
       
              flag=true;
        }
        else{
               flag=false;
        }



  }
    for(int i=1;i<=3;i++){
final res = await _db.rawUpdate("update rental_month set monthlyrent='" +
        addrent.rent +
        "' where yearcycle='" +
        addrent.year +
        "' and month='" +
        i.toString() +
        "' and user_id='" +
        addrent.userid +
        "'");
        if(res>0){
       
                flag=true;
        }
        else{
            flag=false;
        }



  }

}
else if(int.parse(addrent.month)<=3){
  for(int i=int.parse(addrent.month);i<=3;i++){
final res = await _db.rawUpdate("update rental_month set monthlyrent='" +
        addrent.rent +
        "' where yearcycle='" +
        addrent.year +
        "' and month='" +
        i.toString() +
        "' and user_id='" +
        addrent.userid +
        "'");
        if(res>0){
       
                flag=true;
        }
        else{
              flag=false;
        }



  }


}
     }
}
}
else{
 return flag;
}
return flag;
}




// create report

Future<String> creatReport(String yearcycle) async{
  final _db = await initDB();
final DateTime now = DateTime.now();
String yearcycle1="";

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);
PdfGridRow row ;
String rent="";
String rents="";
String rentname="";
String rentpayed="";
String rentdue="";
String totalrent="";
String totaluserrent="";
String rentneedtopay="";
String period="";
String totalrentfull="";
  String rentmonth="";
String rentrecieved="";
int i=0;
String years="";
String cycle="";
if(int.parse(monthnow)>=4){

  yearcycle1=yearnow+'-'+(int.parse(yearnow)+1).toString();
  years='4/'+yearnow+' to '+monthnow+'/'+yearnow;
}
else if(int.parse(monthnow)<=3){
  yearcycle1=(int.parse(yearnow)-1).toString()+'-'+yearnow;
    years='4/'+(int.parse(yearnow)-1).toString()+' to '+monthnow+'/'+yearnow;
}
if(yearcycle==yearcycle1){
final PdfDocument document = PdfDocument();
// Add a new page to the document.
final PdfPage page = document.pages.add();

final PdfLayoutResult layoutResult = PdfTextElement(
        text: "Immaculate Conception Church Mananthavady",
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Draw the next paragraph/content.
page.graphics.drawLine(
    PdfPen(PdfColor(255, 0, 0)),
    Offset(0, layoutResult.bounds.bottom + 10),
    Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));


    final PdfLayoutResult layoutResult1 = PdfTextElement(
        text: "Year Cycle: "+yearcycle,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,50, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

        totalrentfull=await db.rentperyear1(yearcycle);
       rentrecieved=await db.rentrentrecieved1(yearcycle);
       rentmonth= await db.renttotalmonth(yearcycle);
         final PdfLayoutResult layoutResult2 = PdfTextElement(
        text: "Total Rent/year: "+totalrentfull,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,75, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
         final PdfLayoutResult layoutResult3 = PdfTextElement(
        text: "Rent Recieved : "+rentrecieved,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,100, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
              final PdfLayoutResult layoutResult4 = PdfTextElement(
        text: "Total Due : "+((int.parse(rentmonth))-int.parse(rentrecieved)).toString(),
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,125, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
             final PdfLayoutResult layoutResult5 = PdfTextElement(
        text: "Period : "+years,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,150, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Create a PDF grid class to add tables.
final PdfGrid grid = PdfGrid();
// Specify the grid column count.
grid.columns.add(count: 5);
// Add a grid header row.
final PdfGridRow headerRow = grid.headers.add(1)[0];
headerRow.cells[0].value = 'Name';
headerRow.cells[1].value = 'Period';
headerRow.cells[2].value = 'Rent Payed';
headerRow.cells[3].value = 'Due';
headerRow.cells[4].value = 'Rent/year';
// Se
headerRow.style.font =
    PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
// Add rows to the grid.
if(yearcycle==yearcycle1){

var map=await _db.rawQuery('SELECT * from rental_icc where  yearcycle=?',
[yearcycle]
);
if(map.length>0){
  do{

rentname=map[i]['rent_name'];
 totaluserrent= await db.rentperyearusers(map[i]['id'].toString(), yearcycle);
  rentpayed=await db.rentpayedusers(map[i]['id'].toString(), yearcycle);
   
    rentneedtopay=await db.rentneedtopayusers(map[i]['id'].toString(), yearcycle);

    period= map[i]['rentstartedmonth']+'/'+map[i]['rentstartedyear']+' to '+monthnow+'/'+yearnow;
   PdfGridRow row = grid.rows.add();

row.cells[0].value = rentname;
row.cells[1].value =period;
row.cells[2].value = rentpayed;
row.cells[3].value = (int.parse(rentneedtopay)-int.parse(rentpayed)).toString();
row.cells[4].value = totaluserrent;





// Add next row.
i++;
}while(i<map.length);
// Add next row.
  }
}
// Set grid format.
grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
// Draw table in the PDF page.
grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
        0,200, page.getClientSize().width, page.getClientSize().height));
// Save the document.
// io.File('PDFTable.pdf').writeAsBytes(document.save());
String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['pdf'],
  fileName: 'generated22.pdf',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = io.File(outputFile);
 of.writeAsBytes(document.save());
  document.dispose();
}
// Dispose the document.






  return "success";
}
else{

final PdfDocument document = PdfDocument();
// Add a new page to the document.
final PdfPage page = document.pages.add();

final PdfLayoutResult layoutResult = PdfTextElement(
        text: "Immaculate Conception Church Mananthavady",
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Draw the next paragraph/content.
page.graphics.drawLine(
    PdfPen(PdfColor(255, 0, 0)),
    Offset(0, layoutResult.bounds.bottom + 10),
    Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));


    final PdfLayoutResult layoutResult1 = PdfTextElement(
        text: "Year Cycle: "+yearcycle,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,50, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

        totalrentfull=await db.rentperyear2(yearcycle);
       rentrecieved=await db.rentrentrecieved2(yearcycle);
       rentmonth= await db.renttotalmonth1(yearcycle);
         final PdfLayoutResult layoutResult2 = PdfTextElement(
        text: "Total Rent/year: "+totalrentfull,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,75, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
         final PdfLayoutResult layoutResult3 = PdfTextElement(
        text: "Rent Recieved : "+rentrecieved,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,100, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
              final PdfLayoutResult layoutResult4 = PdfTextElement(
        text: "Total Due : "+((int.parse(rentmonth))-int.parse(rentrecieved)).toString(),
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,125, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
             final PdfLayoutResult layoutResult5 = PdfTextElement(
        text: "Period : "+years,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,150, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Create a PDF grid class to add tables.
final PdfGrid grid = PdfGrid();
// Specify the grid column count.
grid.columns.add(count: 5);
// Add a grid header row.
final PdfGridRow headerRow = grid.headers.add(1)[0];
headerRow.cells[0].value = 'Name';
headerRow.cells[1].value = 'Period';
headerRow.cells[2].value = 'Rent Payed';
headerRow.cells[3].value = 'Due';
headerRow.cells[4].value = 'Rent/year';
// Se
headerRow.style.font =
    PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
// Add rows to the grid.
if(yearcycle==yearcycle1){

var map=await _db.rawQuery('SELECT * from rental_icc where  yearcycle=?',
[yearcycle]
);
if(map.length>0){
  do{

rentname=map[i]['rent_name'];
 totaluserrent= await db.rentperyearusers1(map[i]['id'].toString(), yearcycle);
  rentpayed=await db.rentpayedusers1(map[i]['id'].toString(), yearcycle);
   
    rentneedtopay=await db.rentneedtopayusers1(map[i]['id'].toString(), yearcycle);
period=await db.lastmonthuser(map[i]['id'].toString(), yearcycle);
cycle= map[i]['rentstartedmonth']+'/'+map[i]['rentstartedyear']+' to '+period;
   PdfGridRow row = grid.rows.add();

row.cells[0].value = rentname;
row.cells[1].value =cycle;
row.cells[2].value = rentpayed;
row.cells[3].value = (int.parse(rentneedtopay)-int.parse(rentpayed)).toString();
row.cells[4].value = totaluserrent;





// Add next row.
i++;
}while(i<map.length);
// Add next row.
  }
}
// Set grid format.
grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
// Draw table in the PDF page.
grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
        0,200, page.getClientSize().width, page.getClientSize().height));
// Save the document.
// io.File('PDFTable.pdf').writeAsBytes(document.save());
String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['pdf'],
  fileName: 'generated22.pdf',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = io.File(outputFile);
 of.writeAsBytes(document.save());
  document.dispose();
}
// Dispose the document.






  return "success";






}
}

Future<String> creatdocmonthReport(String month,String yearcycle) async{
  final _db = await initDB();
final DateTime now = DateTime.now();
String yearcycle1="";

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);
PdfGridRow row ;
String rent="";
String rents="";
String rentname="";
String rentpayed="";
String rentdue="";
String totalrent="";
String totaluserrent="";
String rentneedtopay="";
String period="";
String totalrentfull="";
  String rentmonth="";
String rentrecieved="";
int i=0;
String years="";
String cycle="";


final PdfDocument document = PdfDocument();
// Add a new page to the document.
final PdfPage page = document.pages.add();

final PdfLayoutResult layoutResult = PdfTextElement(
        text: "Immaculate Conception Church Mananthavady",
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Draw the next paragraph/content.
page.graphics.drawLine(
    PdfPen(PdfColor(255, 0, 0)),
    Offset(0, layoutResult.bounds.bottom + 10),
    Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));


    final PdfLayoutResult layoutResult1 = PdfTextElement(
        text: "Year Cycle: "+yearcycle,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,50, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

        totalrentfull=await db.rentperyear1(yearcycle);
       rentrecieved=await db.totalmonthlyrentrecieved(month,yearcycle);
       rentmonth= await db.totalmonthlyrentneedtopayed(month,yearcycle);
         final PdfLayoutResult layoutResult2 = PdfTextElement(
        text: "Total Rent/year: "+totalrentfull,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,75, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
         final PdfLayoutResult layoutResult3 = PdfTextElement(
        text: "Rent Recieved : "+rentrecieved,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,100, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
              final PdfLayoutResult layoutResult4 = PdfTextElement(
        text: "Total Due : "+((int.parse(rentmonth))-int.parse(rentrecieved)).toString(),
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,125, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
                 final PdfLayoutResult layoutResult5 = PdfTextElement(
        text: "Month : "+month,
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0,150, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
             
// Create a PDF grid class to add tables.
final PdfGrid grid = PdfGrid();
// Specify the grid column count.
grid.columns.add(count: 5);
// Add a grid header row.
final PdfGridRow headerRow = grid.headers.add(1)[0];
headerRow.cells[0].value = 'Name';
headerRow.cells[1].value = 'Room';
headerRow.cells[2].value = 'Monthly Rent';
headerRow.cells[3].value = 'Month ';
headerRow.cells[4].value = 'Rent Payed';
// Se
headerRow.style.font =
    PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
// Add rows to the grid.


var map=await _db.rawQuery('SELECT * from rental_month where month=? and yearcycle=?',
[month,yearcycle]
);
if(map.length>0){
  do{

rentname=map[i]['rent_name'];
 totaluserrent= await db.rentperyearusers(map[i]['id'].toString(), yearcycle);
  rentpayed=await db.totalmonthlyrent(month, yearcycle, map[i]['id'].toString());
  if(int.parse(rentpayed)==0){
    rentpayed="";
  }
    rentneedtopay=await db.rentneedtopayusers(map[i]['id'].toString(), yearcycle);

rent=map[i]['monthlyrent'];
   PdfGridRow row = grid.rows.add();

row.cells[0].value = rentname;
row.cells[1].value=map[i]['room_no'];
row.cells[2].value =rent;
row.cells[3].value = month;
row.cells[4].value = rentpayed;





// Add next row.
i++;
}while(i<map.length);
// Add next row.
  }

// Set grid format.
grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
// Draw table in the PDF page.
grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
        0,200, page.getClientSize().width, page.getClientSize().height));
// Save the document.
// io.File('PDFTable.pdf').writeAsBytes(document.save());
String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save file:',
   allowedExtensions: ['pdf'],
  fileName: 'generated22.pdf',
);

if (outputFile == null) {
  return "Error";
}
else{
  final of = io.File(outputFile);
 of.writeAsBytes(document.save());
  document.dispose();
}
// Dispose the document.






  return "success";


}


 Future<String> totalmonthlyrent(String month,String year,String userid) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();
int rent=0;
    List<RentMonth> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_month where user_id=? and month=? and yearcycle=?',
  [userid,month,year]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
       rent+=int.parse(res[i]['rentpayed']);
      }
      return rent.toString();
    }
   return rent.toString();    
 }    

 Future<String> totalmonthlyrentneedtopayed(String month,String year) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();
int rent=0;
    List<RentMonth> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_month where month=? and yearcycle=?',
  [month,year]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
       rent+=int.parse(res[i]['monthlyrent']);
      }
      return rent.toString();
    }
   return rent.toString();    
 }    

 Future<String> totalmonthlyrentrecieved(String month,String year) async {    
final _db = await initDB();   
 final DateTime now = DateTime.now();
int rent=0;
    List<RentMonth> _rentusercsv = [];
  var res = await _db.rawQuery('SELECT * from rental_month where month=? and yearcycle=?',
  [month,year]);
// Get first result

    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
       rent+=int.parse(res[i]['rentpayed']);
      }
      return rent.toString();
    }
   return rent.toString();    
 }    

Future <String> deactivate(Addrent addrent) async{
String yearstart="";
  final _db = await initDB();
String flag="";
var maps=await _db.rawQuery('SELECT * from rental_icc where id=? and  yearcycle=?',
[addrent.userid,addrent.year]
);
if(maps.length>0){

  if(int.parse(addrent.month)>=4){
for(int i=int.parse(addrent.month);i<=12;i++){

  final res = await _db.rawDelete("DELETE FROM rental_month where user_id='" + addrent.userid+ "' and month='"+addrent.month+"' and yearcycle='"+addrent.year+"'");



}
for(int i=1;i<=3;i++){

  final res = await _db.rawDelete("DELETE FROM rental_month where user_id='" + addrent.userid + "' and month='"+addrent.month+"' and yearcycle='"+addrent.year+"'");



}

  }


  
  if(int.parse(addrent.month)<=3){

for(int i=int.parse(addrent.month);i<=3;i++){

  final res = await _db.rawDelete("DELETE FROM rental_month where user_id='" + addrent.userid+ "' and month='"+addrent.month+"' and yearcycle='"+addrent.year+"'");



}

  }
final res = await _db.rawUpdate("update rental_icc set status='not active' where yearcycle='" +
        addrent.year +
        "' and  id='" +
     addrent.userid +
        "'");
        if(res>0){
       
                flag="Success";
        }
        else{
              flag="Success";
        }


}
else{
  flag="Error";
}
return flag;
}



  Future<bool> checkative(String userid,String yearcycle) async{

  final _db = await initDB();
var result = await _db.rawQuery(
    'SELECT * FROM rental_icc WHERE id=? and yearcycle=? and status=?', 
    [userid, yearcycle,'active']
);
return  result.length>0 ? true :false;

  }
}