
// ignore_for_file: prefer_const_constructors, avoid_print, unused_field


import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/services/csvservice.dart';
import 'package:church_windows/ui/widgets/add_rentform.dart';
import 'package:church_windows/ui/widgets/rentformmain.dart';

import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shirne_dialog/shirne_dialog.dart';

import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/rentusercsv.dart';

import 'package:church_windows/themes/light_color.dart';
import 'package:church_windows/themes/theme.dart';

import 'package:church_windows/ui/shared/spacing.dart';

import 'package:church_windows/ui/widgets/main_header.dart';
import 'package:church_windows/widget/extentions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';


class Rentaluserdet extends StatefulWidget {
final String? userid;
final String? yearcycle;
  const Rentaluserdet({Key? key,this.userid,this.yearcycle}) : super(key: key);

  @override
  State<Rentaluserdet> createState() => _RentaluserdetState();
}

class _RentaluserdetState extends State<Rentaluserdet> {
Future<List<RentMonth>>? rentuserlist;
List<RentMonth> userdet=[];
List<RentMonth> filterrentlist=[];
bool _isloading=false;
RentuserCsv? rentli;
 bool loading = true;
 String searchname="";
 String totalrent="0";
 String rentpayeduser="0";

 String renttotaldueuser="0";
 String totaldue="0";
 String yearcycle="";
bool isactive=true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userid.toString()+"hiii");
    sqfliteFfiInit();
    setState(() {
      yearcycle=widget.yearcycle.toString();
    });
  rentuserlist=DBProvider.db.getAllDet(widget.userid.toString(),yearcycle);
  DBProvider.db.rentperyearusers(widget.userid.toString(),yearcycle);


 DBProvider.db.checkative(widget.userid.toString(), yearcycle).then((value) {
  setState(() {
    isactive=value;
 });
});
DBProvider.db.rentpayedusers(widget.userid.toString(),yearcycle).then((value) {
if(value!="error"){
  setState(() {
    rentpayeduser=value;
      // DBProvider.db.transferRenttable();
  DBProvider.db.rentneedtopayusers(widget.userid.toString(),yearcycle).then((value) {
    
   setState(() {
     totalrent=(int.parse(value)-int.parse(rentpayeduser)).toString();
   });
  });
  });
DBProvider.db.renttotaldueusers(widget.userid.toString(),yearcycle).then((value) {
    if(value!="error"){

setState(() {
  renttotaldueuser=value;
  totaldue=value;
});


    }
  
  });
}
});

   // DBProvider.db.transferRenttable();
  
  rentuserlist?.then((value) {
  
    setState(() {
filterrentlist=value;
if(filterrentlist.isNotEmpty){
  setState(() {
    _isloading=true;
  });
}
      
    });
  });
   

  

    var dateParse =DateFormat.MMMM('en_US').format(DateTime.now());
    var formattedDate = dateParse;
print(formattedDate.toString().toLowerCase());
  }
   Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }
  @override
  Widget build(BuildContext context) {


   final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

    MyDialog.initialize(
      context,
      MyDialogSetting(
        buttonTextOK: '确定',
        buttonTextCancel: '取消',
        primaryButtonStyle: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
        cancelButtonStyle: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
        modalSetting: ModalSetting(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
      return CustomScrollView(
      controller: ScrollController(),
       shrinkWrap: true,
       slivers: <Widget>[
         SliverList(delegate: SliverChildListDelegate(
    [
     
              verticalSpaceSmall,
           MainHeader(),
          
              verticalSpaceRegular,
       
    if(_isloading)...[   
      LayoutBuilder(
                  builder: (ctx, constrain) {
  return Column(
          children:[
            verticalSpaceRegular,
            // ignore: prefer_const_constructors

 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [
Container(
    color: Color.fromARGB(255, 236, 236, 236),
      width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.all(20),
  child: Column(
 
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("NAME",style: TextStyle(fontSize: 15),),
Text(filterrentlist.first.rentnamemalayalam,style: TextStyle(fontSize: 20),),
  ]),
),
Container(
    width: MediaQuery.of(context).size.width,
  color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Room #",style: TextStyle(fontSize: 15),),
Text(filterrentlist.first.roomno,style: TextStyle(fontSize: 20),),
  ]),
),
Container(
    width: MediaQuery.of(context).size.width,
    color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Building",style: TextStyle(fontSize: 15),),
Text(filterrentlist.first.building,style: TextStyle(fontSize: 20),),
  ]),
),

Container(
    width: MediaQuery.of(context).size.width,
    color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Rent",style: TextStyle(fontSize: 15),),
Text(filterrentlist.first.monthlyrent,style: TextStyle(fontSize: 20),),
  ]),
),
Container(
    width: MediaQuery.of(context).size.width,
    color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Total rent payed",style: TextStyle(fontSize: 15),),
Text(rentpayeduser,style: TextStyle(fontSize: 20),),
  ]),
),
Container(
    width: MediaQuery.of(context).size.width,
    color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Total Due",style: TextStyle(fontSize: 15),),
Text(totalrent,style: TextStyle(fontSize: 20),),
  ]),
),
Container(
    width: MediaQuery.of(context).size.width,
    color: Color.fromARGB(255, 236, 236, 236),
  padding: EdgeInsets.all(20),
  child: Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Text("Total Rent per Year",style: TextStyle(fontSize: 15),),
Text(totaldue,style: TextStyle(fontSize: 20),),
  ]),
),
      ])]);},
    ),


verticalSpaceSmall,
        LayoutBuilder(
                  builder: (ctx, constrain) {
  return Column(
          children:[
            verticalSpaceRegular,
            // ignore: prefer_const_constructors

 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [


                              Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {

                                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  RentFormMain(userid: widget.userid, formtype: "Addrent",yearcycle: widget.yearcycle)),
  );


                    },
                    color: Color.fromARGB(255, 255, 225, 92),
                    child: Text(
                      "Add Rent",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),

                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  RentFormMain(userid: widget.userid, formtype: "editrentuser",yearcycle: widget.yearcycle)),
  );
                    },
                    color: Color.fromARGB(255, 255, 225, 92),
                    child: Text(
                      "Edit Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {

                                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  RentFormMain(userid: widget.userid, formtype: "updaterentform",yearcycle: widget.yearcycle)),
  );
                    },
                    color: Color.fromARGB(255, 255, 225, 92),
                    child: Text(
                      "Update Rent",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
             if(isactive)...[
                  Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {

                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  RentFormMain(userid: widget.userid, formtype: "deactivateuser",yearcycle: widget.yearcycle)),
  );
                    },
                    color: Color.fromARGB(255, 241, 97, 35),
                    child: Text(
                      "Deactivate",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
             
             ]   
           ])]);},
    ),
    ]
    else ...[
      
                
                if(filterrentlist.isEmpty)...
                       [ 
                        Container(
                            child: Center(
                              child: Text('Not available'),
                            ),
                          )
                       ]
    ],verticalSpaceRegular,

                    
                    
       verticalSpaceRegular,

      ],
         )
         )
       ]
    );
  }


   }
