

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new

import 'package:church_windows/modal/demo.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';


class MarriageForm7 extends StatefulWidget {
final String? formtype;
   MarriageForm7({Key? key,this.formtype}) : super(key: key);

  @override
  State<MarriageForm7> createState() => _MarriageForm7State();
}

class _MarriageForm7State extends State<MarriageForm7> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Marriage7 marriage;
bool _isbutton=true;

  String? formatted;
TextEditingController _dateController = TextEditingController();
TextEditingController _datebaptismController = TextEditingController();
TextEditingController _dateControllerbride = TextEditingController();
TextEditingController _datebaptismControllerbride = TextEditingController();
TextEditingController _datemarriageController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
 void initState() {
   super.initState();
final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  setState(() {
  
   marriage = Marriage7("", "", "", "","", "", "", "","","");
  });
  setState(() {
formatted = formatter.format(now);

  });
  
 }
 void createcerti(BuildContext context,Marriage7 _marriage){
    setState(() {
    _isbutton=false;
  });
    Createcertificate.createMarriage7(context,_marriage ).then((value) {
     if(value=="Success"){
      setState(() {
     
       _isbutton=true;
       _formKey.currentState?.reset();
      _dateController.text = "";
_datebaptismController.text = "";
 _dateControllerbride.text = "";
_datebaptismControllerbride.text = "";
 _datemarriageController.text = "";
      });
      
 return             CoolAlert.show(
   context: context,
   width: 350,
   type: CoolAlertType.success,
   text: "Certificate generated successfully!",
);
     }
     else{
      
      setState(() {
   
        _isbutton=true;
          _dateController.text = "";
_datebaptismController.text = "";
 _dateControllerbride.text = "";
_datebaptismControllerbride.text = "";
 _datemarriageController.text = "";
      
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
     Text("Marriage Form VII",style: TextStyle(fontSize: 25),),
     Text("Declaration made by the Catholic party in a Mixed Marriage / Inter-faith Marriage.",style: TextStyle(fontSize: 20),),
     
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
            Align(
              alignment:Alignment.topLeft,
              child:Text("Catholic Party ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
            ),verticalSpaceRegular,
 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [
   TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Name & surname" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.catholicname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.catholicname= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter name & surname";
    }
    else{
      setState(() {
 marriage.catholicname=value;
      });
    }
                    },
                  ),
                  DropdownButtonFormField(
                              items: <String>[
                            'Male',
                            'Female'

                              ].map((String category) {
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(category,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                                    marriage.catholicgender = value.toString();
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                    marriage.catholicgender = value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select gender ';
                                }
                               else{
   setState(() {
                                    marriage.catholicgender = value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select gender" //label text of field
                ),
                            ),
           
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Names of parents" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.catholicparents = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.catholicparents = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Names of his parents";
    }
    else{
      setState(() {
  marriage.catholicname=value;
      });
    }
                    },
                  ),
     
              
           
      ],
      
    ),
  verticalSpaceRegular,
            // ignore: prefer_const_constructors
            Align(
              alignment:Alignment.topLeft,
              child:Text("Non-Catholic or Non-Chirstian ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
            ),verticalSpaceRegular,
 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [
   TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Name & Surname" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicname= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter name & Surname";
    }
    else{
      setState(() {
 marriage.noncatholicname=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Name of Parents" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicparents= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicparents=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Parents name";
    }
    else{
      setState(() {
  marriage.noncatholicparents=value;
      });
    }
                    },
                  ),

DropdownButtonFormField(
                              items: <String>[
                            'Male',
                            'Female'

                              ].map((String category) {
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(category,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                                    marriage.noncatholicgender = value.toString();
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                    marriage.noncatholicgender = value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select gender ';
                                }
                               else{
   setState(() {
                                    marriage.noncatholicgender = value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select gender" //label text of field
                ),
                            ),
               DropdownButtonFormField(
                              items: <String>[
                            'Non-Catholic',
                            'Non-Christian'

                              ].map((String category) {
                                
                                return new DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text(category,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (value) {
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 setState(() {
                                    marriage.noncatholictype = value.toString();
                                });
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (value) {
                                setState(() {
                                    marriage.noncatholictype = value.toString();
                                });
                              
                              },
                              validator: (value) {
                                if (value==null) {
                                  return 'Select Category ';
                                }
                               else{
   setState(() {
                                    marriage.noncatholictype = value.toString();
                                });
                               }
                              },
                                decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Select Category" //label text of field
                ),
                            ),

                            (marriage.noncatholictype=="Non-Catholic")?
                                   TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Church" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicstatus= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicstatus=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Church name";
    }
    else{
      setState(() {
  marriage.noncatholicstatus=value;
      });
    }
                    },
                  ):(marriage.noncatholictype=="Non-Christian")?    TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Religion and Cast" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicstatus= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicstatus=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Religion and Cast";
    }
    else{
      setState(() {
  marriage.noncatholicstatus=value;
      });
    }
                    },
                  ):       TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Residing at" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicresiding= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicresiding=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter residing at";
    }
    else{
      setState(() {
  marriage.noncatholicresiding=value;
      });
    }
                    },
                  ),  
   
     
            (marriage.noncatholictype=="Non-Christian" || marriage.noncatholictype=="Non-Catholic")?    TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Residing at" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.noncatholicresiding= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.noncatholicresiding=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter residing at";
    }
    else{
      setState(() {
  marriage.noncatholicresiding=value;
      });
    }
                    },
                  ):SizedBox(), 
   
           
      ],
      
    ),

   


 verticalSpaceRegular,
            // ignore: prefer_const_constructors
            if(_isbutton)...[Align(
              alignment:Alignment.topLeft,
              child: FlatButton(
                  height: 60,
                  color: Colors.grey[350],
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isbutton=false;
                        });
                     createcerti(context,marriage);
                      }
                    },
                    child: const Text("Submit"),
                  ),)],
            verticalSpaceRegular,
        
      ]) );}) ],));
      
  }
 
}
