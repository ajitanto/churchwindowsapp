




import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/rentusercsv.dart';
import 'package:church_windows/services/csvservice.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';






class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

 String? _finalDate;


  @override

 void initState() {
    super.initState();
    getCurrentDate();
    sqfliteFfiInit();
    DBProvider.db.initDB();
    importCSV();

 }


 void importCSV() async{
 //Pick file

// Services.rentUSerCsvs();

}
  getCurrentDate(){



    // var dateParse = DateTime.parse(date);
    var dateParse =DateFormat.MMMM('en_US').format(DateTime.now());
    var formattedDate = dateParse;

    setState(() {

      _finalDate = formattedDate.toString() ;

    });

  }


  @override

  Widget build(BuildContext context) {
return Scaffold(
 
  body: SingleChildScrollView(child: Column(children: [
Container(  

padding: EdgeInsets.only(left: 20,right: 20),
  child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
  Container(
    height: 70,
    child: GestureDetector(
      child:Icon(Icons.settings,color: Colors.black54,),
      onTap: (){

    },),
  ),
    Container(
    child: Text("Immaculate Conception Church",style: TextStyle(color: Colors.black54,fontSize: 25),),
  )
    ],)),
    SizedBox(height: 50,),
  
// Align(
//   alignment: Alignment.center,
//   child:
// OutlinedButton(
//       onPressed: () {
//       Services.rentUSerCsvs();
//       },
//       child: const Text('Click Me'),
//     ),

// )
  ]),
));
  
  }
  

}
