

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new, unrelated_type_equality_checks



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


class AddrentUser extends StatefulWidget {
final String? userid;
final String? formtype;
final String? yearcycle;
   AddrentUser({Key? key,this.userid,this.formtype,this.yearcycle}) : super(key: key);

  @override
  State<AddrentUser> createState() => _AddrentUserState();
}

class _AddrentUserState extends State<AddrentUser> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late RentuserCsv rentuserCsv;
 String startyear="";
bool _isLoading=false;
bool _isbutton=true;
String month="";
String year="";
int month1=0;
List<RentMonth> user=[];
String selectdmonth="";
List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November',  'December'];
List<String> currntyear=[];
TextEditingController _textController = TextEditingController();

  
  String? formatted;
  String addeddate="";

  DateTime selectedDate = DateTime.now();
  @override
 void initState() {
   super.initState();

    

 final DateTime now = DateTime.now();


  setState(() {
  month=DateFormat.M().format(now);
year=DateFormat.y().format(now);

for(int i=int.parse(year);i<=int.parse(year)+1;i++){
  setState(() {
    currntyear.add(i.toString());
  });
}

   rentuserCsv = RentuserCsv("", "", "", "","","","","","","","");
  
   
  });

  setState(() {


  });
  
 }
 Future<void> createnewuser(BuildContext context,RentuserCsv _rentcsv) async {
   setState(() {
     _isLoading=true;
     _isbutton=false;
     
   });
 var isLoggedIn =await  DBProvider.db.loginstatusarg(_rentcsv.rentname,_rentcsv.roomno,_rentcsv.building,_rentcsv.rent,'active',_rentcsv.rentstartedmonth,_rentcsv.rentstartedyear);
              if (isLoggedIn) {
                setState(() {
                              _isLoading=false;
     _isbutton=true;
   
                });
                 return             CoolAlert.show(
   context: context,
   width: 350,
   type: CoolAlertType.error,
   text: "User data already exist!",
);

              }
              else{
              DBProvider.db.addnewRentuser(_rentcsv ).then((value) {
     if(value=="Success"){
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

  }
  
  @override
  Widget build(BuildContext context) {

 
    final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

      return  Container(

        padding: EdgeInsets.all(15),
        child:Column(children: [
        
     // ignore: prefer_const_constructors
     Text("Add new user",style: TextStyle(fontSize: 25),),
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
 rentuserCsv.rentstartedmonth=DateFormat.M().format(parsedDate).toString();
print(rentuserCsv.rentstartedmonth);
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                  setState(() {
                         
var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 rentuserCsv.rentstartedmonth=DateFormat.M().format(parsedDate).toString();
print(rentuserCsv.rentstartedmonth);
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return ' Select Month ';
                                }
                               else{
       setState(() {
                         
var parsedDate =  DateFormat('MMMM', 'en_US').parse(value.toString());
 rentuserCsv.rentstartedmonth=DateFormat.M().format(parsedDate).toString();
print(rentuserCsv.rentstartedmonth);
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
                            rentuserCsv.rentstartedyear=value.toString();

                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                      rentuserCsv.rentstartedyear=value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return ' Select Year ';
                                }
                               else{
   setState(() {
    rentuserCsv.rentstartedyear=value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Starting Year" //label text of field
                ),
                            ),
          
   TextFormField(
   
  //     keyboardType: TextInputType.number,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  // ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Full Name (English)" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.rentname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.rentname= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Full Name (English)";
    }
    else{
      setState(() {
 rentuserCsv.rentname=value;
      });
    }
                    },
                  ),
     
          TextFormField(

  //     keyboardType: TextInputType.number,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  // ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Full Name ( Malayalam )" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.rentnamemalayalam = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.rentnamemalayalam= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Full Name ( Malayalam )";
    }
    else{
      setState(() {
 rentuserCsv.rentnamemalayalam=value;
      });
    }
                    },
                  ),


                     TextFormField(
 //     keyboardType: TextInputType.number,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  // ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Room No" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.roomno = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.roomno= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
    rentuserCsv.roomno="";
    }
    else{
      setState(() {
 rentuserCsv.roomno=value;
      });
    }
                    },
                  ),
     
          TextFormField(
    
  //     keyboardType: TextInputType.number,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  // ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Building" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.building = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.building= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
     rentuserCsv.building="";
    }
    else{
      setState(() {
 rentuserCsv.building=value;
      });
    }
                    },
                  ),
     
          TextFormField(
  
      keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Rent per Month" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.rent = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.rent= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter rent";
    }
    else{
      setState(() {
 rentuserCsv.rent=value;
      });
    }
                    },
                  ),
     
          TextFormField(

  //     keyboardType: TextInputType.number,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  // ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Type" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.type = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.type= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
     rentuserCsv.type="";
    }
    else{
      setState(() {
 rentuserCsv.type=value;
      });
    }
                    },
                  ),
     
          TextFormField(

      keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ],
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Prev Due " //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      rentuserCsv.prevdue = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        rentuserCsv.prevdue= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
rentuserCsv.prevdue="";
    }
    else{
      setState(() {
 rentuserCsv.prevdue=value;
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
  
 
                         
                          _isbutton=false;
                        });
                     createnewuser(context,rentuserCsv);
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
