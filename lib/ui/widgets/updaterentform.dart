

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new



import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';


class Updaterentuser extends StatefulWidget {
final String? userid;
final String? formtype;
final String? yearcycle;
   Updaterentuser({Key? key,this.userid,this.formtype,this.yearcycle}) : super(key: key);

  @override
  State<Updaterentuser> createState() => _UpdaterentuserState();
}

class _UpdaterentuserState extends State<Updaterentuser> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Addrent addrent;
 String startyear="";
bool _isLoading=false;
bool _isbutton=true;
String month="";
String year="";
int month1=0;
List<RentMonth> user=[];
String selectdmonth="";
List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November',  'December'];
TextEditingController _textController = TextEditingController();

  
  String? formatted;
  String addeddate="";
List<String> currntyear=[];
  DateTime selectedDate = DateTime.now();
  @override
 void initState() {
   super.initState();


 final DateTime now = DateTime.now();


  setState(() {
  month=DateFormat.M().format(now);
year=DateFormat.y().format(now);


for(int i=int.parse(year);i<=int.parse(year)+2;i++){
  setState(() {
    currntyear.add((i).toString()+'-'+(i+1).toString());
  });
}

DBProvider.db.getAllDetwith(widget.userid.toString(),widget.yearcycle.toString()).then((values) {
setState(() {
  user=values;
});



});
   addrent = Addrent("", "", "", "");
  
   
  });

  setState(() {


  });
  
 }
 void createcerti(BuildContext context,Addrent _addrent){
   setState(() {
     _isLoading=true;
     _isbutton=false;
   });
    DBProvider.db.updateRent(_addrent ).then((value) {
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
   text: "Rent added Succesfully!",
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
     Text("Update Rent",style: TextStyle(fontSize: 25),),
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
 addrent.month=DateFormat.M().format(parsedDate).toString();
print(addrent.month);


                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                  setState(() {
                         
var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 addrent.month=DateFormat.M().format(parsedDate).toString();
print(addrent.month);
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return ' Select Month ';
                                }
                               else{
       setState(() {
                         
var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 addrent.month=DateFormat.M().format(parsedDate).toString();
print(addrent.month);
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Starting Month" //label text of field
                ),
                            ),
         
                     DropdownButtonFormField(
                              items: currntyear.map((map) {
                             
                                
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
                            addrent.year=value.toString();
                            print(addrent.year);

                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                     addrent.year=value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return ' Select Year ';
                                }
                               else{
   setState(() {
    addrent.year=value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Year year cycle" //label text of field
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
                   labelText: "Updated Rent" //label text of field
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
      return "Enter Updated Rent";
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


                          addrent.userid=widget.userid.toString();
                        
                          _isbutton=false;
                        });
                     createcerti(context,addrent);
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
