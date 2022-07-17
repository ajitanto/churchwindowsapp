
// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_new


import 'package:church_windows/main/addnewrentusermain.dart';
import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/services/csvservice.dart';
import 'package:church_windows/ui/widgets/rentlistmainuser.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';

import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/rentusercsv.dart';

import 'package:church_windows/themes/light_color.dart';
import 'package:church_windows/themes/theme.dart';

import 'package:church_windows/ui/shared/spacing.dart';

import 'package:church_windows/ui/widgets/main_header.dart';
import 'package:church_windows/widget/extentions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shirne_dialog/shirne_dialog.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



class Rentallist extends StatefulWidget {
 final String ? yearcycle; 
  const Rentallist({Key? key,this.yearcycle}) : super(key: key);

  @override
  State<Rentallist> createState() => _RentallistState();
}

class _RentallistState extends State<Rentallist> {
Future<List<RentMonth>>? rentuserlist;
List<RentMonth> rentlist=[];
List<RentMonth> filterrentlist=[];
RentuserCsv? rentli;
 late Addrent addrent;
 bool loading = true;
 String searchname="";
 String totalrent="0";
 String totalrentrec="0";
 String sync="";
 String renttotaldue="0";
 String yearcycle="";
 bool _isbutton=true;
 bool _isbuttons=true;
 bool _isLoadings=false;
 bool _isbuttonss=true;
 String monthcycle="";
 String cycleyear="";
 String selectdmonth="";
 List<RentMonth> user=[];
 List<String> yearcyclelist=[];
 List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November',  'December'];
 String month="";
 final searchHolder = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
   final GlobalKey<FormState> _formKey1 = GlobalKey();
   final GlobalKey<FormState> _formKey2 = GlobalKey();
   TextEditingController _textController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqfliteFfiInit();
     final DateTime now = DateTime.now();
MyDialog.initialize(context,MyDialogSetting());
String months=DateFormat.M().format(now);
String year=DateFormat.y().format(now);

 setState(() {
   addrent = Addrent("", "", "", "");
  month=months;
   yearcycle=widget.yearcycle.toString();
   });
rentuserlist=DBProvider.db.getAllRent(yearcycle);
   rentuserlist?.then((value) {
    if(value.isNotEmpty){
    setState(() {
      rentlist=value;
         filterrentlist=value;
      loading=false;
    
    });
    }
    else{
      setState(() {
        filterrentlist=[];
      loading=false;
      });
 
    }
   });
  
  // DBProvider.db.transferRenttable();
  DBProvider.db.rentperyear1(yearcycle).then((value) {
   setState(() {
     totalrent=value;
   });
  });




  DBProvider.db.yearcycleList().then((value) {
   setState(() {
     yearcyclelist=value;
   });
  });


   DBProvider.db.rentrentrecieved1(yearcycle).then((value) {
   setState(() {
    if(value!="error"){
     totalrentrec=value;
     DBProvider.db.renttotalmonth(yearcycle).then((value) {
   setState(() {
    if(value!="error"){
setState(() {
  renttotaldue=(int.parse(value)-int.parse(totalrentrec)).toString();

});
    }else{
      setState(() {
         renttotaldue="0";
      });
        
    }
   });
  });
    }
    else{
setState(() {
  totalrentrec="0";
});
    }
   });
  });
  

  

    var dateParse =DateFormat.MMMM('en_US').format(DateTime.now());
    var formattedDate = dateParse;
print(formattedDate.toString().toLowerCase());
  }


   void createcerti(BuildContext context,String yearcycle){
   setState(() {
   
     _isbutton=false;
   });
    DBProvider.db.creatReport(yearcycle ).then((value) {
      setState(() {
         _isbutton=true;
      });
   
    });
  
  
  }
 void addrents(BuildContext context,Addrent _addrent){
   setState(() {
     _isLoadings=true;
     _isbuttonss=false;
   });
    DBProvider.db.addRent(_addrent ).then((value) {
     if(value){
      setState(() {
        _isLoadings=false; 
       _isbuttonss=true;
       _textController.text="";
       _formKey2.currentState?.reset();
          DBProvider.db.rentrentrecieved1(yearcycle).then((value) {
   setState(() {
    if(value!="error"){
     totalrentrec=value;
     DBProvider.db.renttotalmonth(yearcycle).then((value) {
   setState(() {
    if(value!="error"){
setState(() {
  renttotaldue=(int.parse(value)-int.parse(totalrentrec)).toString();

});
    }else{
      setState(() {
         renttotaldue="0";
      });
        
    }
   });
  });
    }
    else{
setState(() {
  totalrentrec="0";
});
    }
   });
  });
   
      });
      
 return             CoolAlert.show(
   context: context,
   width: 350,
   type: CoolAlertType.success,
   text: "Rent added Succesfully!",
);
     }
     else{
      
      setState(() {
        _isLoadings=false;
        _isbuttonss=true;

      
      });

       return             CoolAlert.show(
   context: context,
   width: 350,
   type: CoolAlertType.error,
   text: "Something went wrong!",
);
        
     }
    });
  
  
  }
  


void createdoc(BuildContext context,String month,String yearcycle){
   setState(() {
   
     _isbuttons=false;
   });
    DBProvider.db.creatdocmonthReport(month,yearcycle ).then((value) {
      setState(() {
         _isbuttons=true;
      });
   
    });
  
  
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
  void addcsvfunction(BuildContext context){
print("hiii");
setState(() {
  loading=true;
});
            Loader.show(context,
  isSafeAreaOverlay: false,
  isBottomBarOverlay: false,
  overlayFromBottom: 0,
  overlayColor: Colors.black26,
  progressIndicator: CircularProgressIndicator(backgroundColor: Colors.red),
  themeData: Theme.of(context)
    .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green))
);
  
    Services.rentUSerCsvs().then((value) {

        Loader.hide();
      

           DBProvider.db.rentperyear1(widget.yearcycle.toString()).then((value) {
   setState(() {
     totalrent=value;
   });
     DBProvider.db.rentperyear1(widget.yearcycle.toString()).then((value) {
   setState(() {
     totalrentrec=value;
   });
 
   DBProvider.db.renttotalmonth(widget.yearcycle.toString()).then((value) {
     setState(() {
    if(value!="error"){
setState(() {
  renttotaldue=(int.parse(value)-int.parse(totalrentrec)).toString();

});
    }else{
      setState(() {
         renttotaldue="0";
      });
        
    }
   });

 
    });
  });
  });

    
  
   
      });
    
  }
  
   void createnewyearcycle(BuildContext context){
print("hiii");
setState(() {
  loading=true;
});
            Loader.show(context,
  isSafeAreaOverlay: false,
  isBottomBarOverlay: false,
  overlayFromBottom: 0,

  overlayColor: Colors.black26,
  progressIndicator: CircularProgressIndicator(backgroundColor: Colors.red),
  themeData: Theme.of(context)
    .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green))
);
  
    DBProvider.db.createnewyearcycle(yearcycle).then((value) {

        Loader.hide();
      

           DBProvider.db.rentperyear1(widget.yearcycle.toString()).then((value) {
   setState(() {
     totalrent=value;
   });
     DBProvider.db.rentperyear1(widget.yearcycle.toString()).then((value) {
   setState(() {
     totalrentrec=value;
   });
 
   DBProvider.db.renttotalmonth(widget.yearcycle.toString()).then((value) {
     setState(() {
    if(value!="error"){
setState(() {
  renttotaldue=(int.parse(value)-int.parse(totalrentrec)).toString();

});
    }else{
      setState(() {
         renttotaldue="0";
      });
        
    }
   });
rentuserlist=DBProvider.db.getAllRent(yearcycle);
        rentuserlist?.then((value) {
    setState(() {
      rentlist=value;
       filterrentlist=rentlist;
  
      print(filterrentlist.first.rentname);
     Loader.hide();
      loading=false;

 
    });

  });
    });
  });
  });

    
  
   
      });
    
  }
  
  void synctodatabase(BuildContext context){
      setState(() {
         loading=true;
      });
  Loader.show(context,
  isSafeAreaOverlay: false,
  isBottomBarOverlay: false,
  overlayFromBottom:0,
  overlayColor: Colors.black26,
  progressIndicator: CircularProgressIndicator(backgroundColor: Colors.red),
  themeData: Theme.of(context)
    .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green))
);
  DBProvider.db.transferRenttable().then((value) {
 Loader.hide();
 
   rentuserlist=DBProvider.db.getAllRent(yearcycle);
   rentuserlist?.then((value) {
    setState(() {
         filterrentlist=value;
      loading=false;
    });
  
  

   
});


  
  });



  }
  @override
  Widget build(BuildContext context) {

 MyDialog.setting = MyDialogSetting(
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
    );
  final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

      return CustomScrollView(
      controller: ScrollController(),
       shrinkWrap: true,
       slivers: <Widget>[
         SliverList(delegate: SliverChildListDelegate(
    [
     
              verticalSpaceSmall,
           MainHeader(),
          
              verticalSpaceRegular,
              Container(
                padding: EdgeInsets.only(left: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Column( children: [
  Container(
    
    
    child: Text("if You are in first time, add rental csv file ",style: TextStyle(fontSize: 20),),),
                 ]),      
            Container(
   
    
    child:OutlinedButton(
      onPressed: () {
       
 addcsvfunction(context);
    },
      child: const Text('Click Me'),
    ),)
            
              ],
              ),
              ),
              verticalSpaceRegular,

            Container(
                padding: EdgeInsets.only(left: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
  Container(
    
    
    child: Text("sync to database ",style: TextStyle(fontSize: 20),),),
            
            Container(
   
    
    child:OutlinedButton(
      onPressed: () {
synctodatabase( context);
      },
      child: const Text('Click Me'),
    ),)
            
              ],
              ),
              ),
              verticalSpaceRegular,
       Container(
                padding: EdgeInsets.only(left: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
  Container(
    
    
    child: Text("Add New Rent User ",style: TextStyle(fontSize: 20),),),
            
            Container(
   
    
    child:OutlinedButton(
      onPressed: () {
       
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddrentUserMain()),
  );
    },
      child: const Text('Click Me'),
    ),)
            
              ],
              ),
              ),
              verticalSpaceRegular,
              Container(
                padding:EdgeInsets.all(20),
child:Column(children: [
    Container(
           
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column( children: [
  Container(
    
    
    child: Text("Genarate Next Year cycle ",style: TextStyle(fontSize: 20),),),
                ]),   
            Container(
   
    
    child:OutlinedButton(
      onPressed: () {
       
   createnewyearcycle(context);
    },
      child: const Text('Click Me'),
    ),)
            
              ],
              ),
              ),
])),         
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
           padding: EdgeInsets.all(10),
  width: MediaQuery.of(context).size.width,
   decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
       
              colors: [
                Colors.amber,
               Colors.amber.shade300,
     
              ],
            ),

    boxShadow: [
      BoxShadow(
        spreadRadius: 1,
        color: Color.fromARGB(255, 206, 206, 206),
        offset: Offset(2, 2),
        
        blurRadius: 3,
      ),
    
    ],
  ),
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
      
Text("TOTAL RENT PER YEAR ("+yearcycle+")",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),
SizedBox(height: 50,),
Text("₹"+totalrent,style:TextStyle(color: Colors.white70,fontSize: 25),textAlign: TextAlign.left,)
      ]),
    ),
    Container(
           padding: EdgeInsets.all(10),
  width: MediaQuery.of(context).size.width,
 decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
       
              colors: [
                Colors.amber,
               Colors.amber.shade300,
     
              ],
            ),

    boxShadow: [
      BoxShadow(
       spreadRadius: 1,
        color: Color.fromARGB(255, 206, 206, 206),
        offset: Offset(2, 2),
        
        blurRadius: 3,
      ),
    
    ],
  ),
    
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
      
Text("TOTAL RENT RECEIVED",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),
SizedBox(height: 50,),
Text("₹"+totalrentrec,style:TextStyle(color: Colors.white70,fontSize: 25),textAlign: TextAlign.left,)
      ]),
   
    ),
   
       Container(
           padding: EdgeInsets.all(10),
  width: MediaQuery.of(context).size.width,
 decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
       
              colors: [
                Colors.amber,
               Colors.amber.shade300,
     
              ],
            ),

    boxShadow: [
      BoxShadow(
      spreadRadius: 1,
        color: Color.fromARGB(255, 206, 206, 206),
        offset: Offset(2, 2),
        
        blurRadius: 3,
      ),
    
    ],
  ),
    
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
      
Text("TOTAL DUE",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),
SizedBox(height: 50,),
Text("₹"+renttotaldue,style:TextStyle(color: Colors.white70,fontSize: 25),textAlign: TextAlign.left,)
      ]),
   
    ),

        Container(
           padding: EdgeInsets.all(10),
  width: MediaQuery.of(context).size.width,
 decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
       
              colors: [
                Colors.amber,
               Colors.amber.shade300,
     
              ],
            ),

    boxShadow: [
      BoxShadow(
      spreadRadius: 1,
        color: Color.fromARGB(255, 206, 206, 206),
        offset: Offset(2, 2),
        
        blurRadius: 3,
      ),
    
    ],
  ),
    
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
      
Text("Create Rent report",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),
Form(

        key:_formKey ,
        child:Column(
          children:[
      DropdownButtonFormField(
                              items: yearcyclelist.map((map) {
                             
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(map,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                value: map,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                               cycleyear=value.toString();

 
   
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                      cycleyear=value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select Month ';
                                }
                               else{
   setState(() {
       cycleyear=value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Year Cycle" //label text of field
                ),
                            ),
          
verticalSpaceRegular,

if(_isbutton==true)...[
            Align(
              alignment:Alignment.topLeft,
              child: FlatButton(
                  height: 60,
                  color: Colors.grey[350],
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                     
     
    //split string
  

                          _isbutton=false;
                        });
                     createcerti(context,cycleyear);
                      }
                    },
                    child: const Text("Submit"),
                  ),),
],
       
          ]))
      ]),
   
    ),

   
       Container(
           padding: EdgeInsets.all(10),
  width: MediaQuery.of(context).size.width,
 decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
       
              colors: [
                Colors.amber,
               Colors.amber.shade300,
     
              ],
            ),

    boxShadow: [
      BoxShadow(
      spreadRadius: 1,
        color: Color.fromARGB(255, 206, 206, 206),
        offset: Offset(2, 2),
        
        blurRadius: 3,
      ),
    
    ],
  ),
    
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
      
Text("Create Monthly Rent Document",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w800),textAlign: TextAlign.left,),
Form(

        key:_formKey1 ,
        child:Column(
          children:[
      DropdownButtonFormField(
                              items: months.map((map) {
                             
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(map,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                value: map,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                            var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 monthcycle=DateFormat.M().format(parsedDate).toString();

 
   
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                     var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 monthcycle=DateFormat.M().format(parsedDate).toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select Month ';
                                }
                               else{
   setState(() {
         var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 monthcycle=DateFormat.M().format(parsedDate).toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select month" //label text of field
                ),
                            ),
          
verticalSpaceRegular,

if(_isbuttons==true)...[
            Align(
              alignment:Alignment.topLeft,
              child: FlatButton(
                  height: 60,
                  color: Colors.grey[350],
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey1.currentState!.validate()) {
                        setState(() {
                     
     
    //split string
  

                          _isbuttons=false;
                        });
                     createdoc(context,monthcycle,yearcycle);
                      }
                    },
                    child: const Text("Submit"),
                  ),),
],
       
          ]))
      ]),
   
    ),

   
      ],
    ),
          ]);}),
    verticalSpaceRegular,
              _search(),
              verticalSpaceRegular,
                    Container(
                child:
              loading?  Center(child: Text("Loading...."),):
                
                filterrentlist.length == 0
                        ? Container(
                            child: Center(
                              child: Text('Not available'),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: PageScrollPhysics(),
                            itemCount: filterrentlist.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                   color: LightColor.lightGrey.withAlpha(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(96, 233, 233, 233),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                   Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: GestureDetector(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(filterrentlist[index].rentnamemalayalam,
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.black87,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: .5,
                                                    height: 1.5)),
                                            Text(
                                              "Room: "+filterrentlist[index].roomno,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                             "Building :"+filterrentlist[index].building,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                           
                                          ],
                                        ),
                                     
                                      ),
                                    ),
                                     
                                     ElevatedButton(
                onPressed: () {


                         setState(() {
  _isLoadings=true;
});
DBProvider.db.getAllDetwith(filterrentlist[index].id.toString(),yearcycle).then((values) {
setState(() {
  user=values;
  _isLoadings=false;
});
});
                  MyDialog.popup(

                      SingleChildScrollView(
                        child:Column(
                          children: [
                          _isLoadings? Container(

        padding: EdgeInsets.all(15),
        child:Column(children: [
        
     // ignore: prefer_const_constructors
     Text("Add Rent",style: TextStyle(fontSize: 25),),
     verticalSpaceRegular,
     // ignore: prefer_const_constructors
  LayoutBuilder(
                  builder: (ctx, constrain) {
             

     return Form(

        key:_formKey2,
        child:Column(
          children:[
            verticalSpaceRegular,
            // ignore: prefer_const_constructors
          verticalSpaceRegular,
 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [

                          DropdownButtonFormField(
                              items: user.map((map) {
                             
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(DateFormat.MMMM().format(DateFormat("M").parse(map.month))+" "+map.year,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                value: map.month+"_"+map.year,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                               selectdmonth=value.toString();

                                 final split = selectdmonth.split('_');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
  
setState(() {
  _isLoadings=true;
});
     DBProvider.db.rentpaymonths(values[0].toString(),values[1].toString(),filterrentlist[index].userid.toString()).then((value) {
       setState(() {
         _textController.text=value;
          _isLoadings=false;
       });
     });
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                      selectdmonth=value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select Month ';
                                }
                               else{
   setState(() {
       selectdmonth=value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Month" //label text of field
                ),
                            ),
          
   TextFormField(
    controller: _textController,
      keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Rent Payed" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      addrent.rent = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        addrent.rent= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Rent Payed";
    }
    else{
      setState(() {
 addrent.rent=value;
      });
    }
                    },
                  ),
     
           
      ],
      
    ),
  verticalSpaceRegular,
            // ignore: prefer_const_constructors

     verticalSpaceRegular,

            // ignore: prefer_const_constructors
if(_isbuttonss==true)...[
            Align(
              alignment:Alignment.topLeft,
              child: FlatButton(
                  height: 60,
                  color: Colors.grey[350],
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey2.currentState!.validate()) {
                        setState(() {
                     
     
    //split string
  
   final split = selectdmonth.split('_');
final Map<int, String> values = {
  for (int i = 0; i < split.length; i++)
    i: split[i]
};
    addrent.month=values[0].toString();
     addrent.year=values[1].toString();
     print(selectdmonth);
                          addrent.userid=filterrentlist[index].userid.toString();
                          _isbuttonss=false;
                        });
                     addrents(context,addrent);
                      }
                    },
                    child: const Text("Submit"),
                  ),),
],
            verticalSpaceRegular,
        
      ]) );}),
      

   
       ],)):Text("Loading")
                          ],
                        )
                      ),
                      isScrollControlled: true);
                },
                child: Text('Add Rent'),
              ),
                                           ElevatedButton(
                onPressed: () {

print(filterrentlist[index].userid);
                   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RentLedgerUser(userid:filterrentlist[index].userid,yearcycle:widget.yearcycle)),
  );
              },
                child: Text('View'),
              ),
    //                                 OutlinedButton(
    //   onPressed: _showDialog,
    //   child: const Text('View'),
    // ),
                                  ],
                                ),
                              );
                            },
                          ))
       ,
       verticalSpaceRegular,

      ],
         )
         )
       ]
    );
  }


   Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: searchHolder,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search clients",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),

                                 onChanged: (string) {
                      setState(() {
                        loading=true;
                        searchname = string;
                
                          filterrentlist = rentlist.where((element) => (element.rentname.toLowerCase() .contains(searchname.toLowerCase()))).toList();
                     loading=false;
                      });
                    },
              
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }
}
