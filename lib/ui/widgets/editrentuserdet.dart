

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new



import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/modal/rentusercsv.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';


class EditRentForm extends StatefulWidget {
final String? userid;
final String? formtype;
final String? yearcycle;
   EditRentForm({Key? key,this.userid,this.formtype,this.yearcycle}) : super(key: key);

  @override
  State<EditRentForm> createState() => _EditRentFormState();
}

class _EditRentFormState extends State<EditRentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Editrentuser editrent;
 Future<List<RentuserCsv>>? rentuserlist;
List<RentuserCsv> userdet=[];
List<RentuserCsv> filterrentlist=[];
 String startyear="";
bool _isLoading=false;
bool _isbutton=true;
String month="";
String year="";
int month1=0;
List<RentMonth> user=[];
String selectdmonth="";

TextEditingController _textControllerrentname = TextEditingController();
TextEditingController _textControllerrentmalayalam = TextEditingController();
TextEditingController _textControllerroom = TextEditingController();
TextEditingController _textControllerbuilding = TextEditingController();
TextEditingController _textControllerphone = TextEditingController();

  
  String? formatted;
  String addeddate="";

  DateTime selectedDate = DateTime.now();
  @override
 void initState() {
   super.initState();


 final DateTime now = DateTime.now();

  rentuserlist=DBProvider.db.getAllDeticc(widget.userid.toString());

rentuserlist?.then((value) {
setState(() {
  filterrentlist=value;

_textControllerrentname.text =filterrentlist.first.rentname;
 _textControllerrentmalayalam.text = filterrentlist.first.rentnamemalayalam;
 _textControllerroom.text = filterrentlist.first.roomno;
 _textControllerbuilding.text = filterrentlist.first.building;
_textControllerphone.text = filterrentlist.first.phone;
});

});



  setState(() {
  month=DateFormat.M().format(now);
year=DateFormat.y().format(now);

DBProvider.db.addedmonth(widget.userid.toString()).then((value) {
setState(() {
DBProvider.db.getAllDetwith(widget.userid.toString(),widget.yearcycle.toString()).then((value) {
setState(() {
  user=value;
});
});

});
});
   editrent = Editrentuser("", "", "", "","","","");
  
   
  });

  setState(() {


  });
  
 }
 void createcerti(BuildContext context,Editrentuser _editrentuser){
   setState(() {
     _isLoading=true;
     _isbutton=false;
   });
    DBProvider.db.editRentuser(_editrentuser ).then((value) {
     if(value){
      setState(() {
        _isLoading=false; 
       _isbutton=true;
       _formKey.currentState?.reset();
   
      });
      
 return             CoolAlert.show(
   context: context,
   width: 350,
   type: CoolAlertType.success,
   text: "Record edited Succesfully!",
);
     }
     else{
      
      setState(() {
        _isLoading=false;
        _isbutton=true;

      
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
  
  @override
  Widget build(BuildContext context) {

 
    final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

      return  Container(

        padding: EdgeInsets.all(15),
        child:Column(children: [
        
     // ignore: prefer_const_constructors
     Text("Add Rent",style: TextStyle(fontSize: 25),),
     verticalSpaceRegular,
     // ignore: prefer_const_constructors
  LayoutBuilder(
                  builder: (ctx, constrain) {
     return Form(

        key:_formKey ,
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

   TextFormField(
    controller: _textControllerrentname,
      
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Name ( English )" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      editrent.rentname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        editrent.rentname = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Name ( English )";
    }
    else{
      setState(() {
editrent.rentname = value;
      });
    }
                    },
                  ),
     


     TextFormField(
    controller: _textControllerrentmalayalam,
     
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Name ( Malayalam )" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      editrent.rentnamemalayalam = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        editrent.rentnamemalayalam= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Name ( English )";
    }
    else{
      setState(() {
 editrent.rentnamemalayalam=value;
      });
    }
                    },
                  ),
     



     TextFormField(
    controller: _textControllerphone,
      keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "phone" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      editrent.phone = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        editrent.phone= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
       setState(() {
 editrent.phone="";
      });
    }
    else{
      setState(() {
 editrent.phone=value;
      });
    }
                    },
                  ),
      TextFormField(
    controller: _textControllerroom,
     
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Room No" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      editrent.room = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        editrent.room= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
       setState(() {
 editrent.room="";
      });
    }
    else{
      setState(() {
 editrent.room=value;
      });
    }
                    },
                  ),

              TextFormField(
    controller: _textControllerbuilding,
     
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Building" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      editrent.building = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        editrent.building= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
       setState(() {
 editrent.building="";
      });
    }
    else{
      setState(() {
 editrent.building=value;
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
  
   editrent.userid=widget.userid.toString();

                          _isbutton=false;
                        });
                     createcerti(context,editrent);
                      }
                    },
                    child: const Text("Submit"),
                  ),),
],
            verticalSpaceRegular,
        
      ]) );}),
      

   
       ],));
    
  }
 
}
