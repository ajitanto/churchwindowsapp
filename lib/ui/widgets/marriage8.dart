

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:church_windows/modal/demo.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';


class MarriageForm8 extends StatefulWidget {
final String? formtype;
   MarriageForm8({Key? key,this.formtype}) : super(key: key);

  @override
  State<MarriageForm8> createState() => _MarriageForm8State();
}

class _MarriageForm8State extends State<MarriageForm8> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Marriage3 marriage;
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
  
   marriage = Marriage3("", "", "", "", "", "", "", "", "", "","","");
  });
  setState(() {
formatted = formatter.format(now);

  });
  
 }
 void createcerti(BuildContext context,Marriage3 _marriage){
    setState(() {
    _isbutton=false;
  });
    Createcertificate.createMarriage8(context,_marriage ).then((value) {
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
     Text("Marriage Form VIII",style: TextStyle(fontSize: 25),),
     Text("Petition for Dispensation from the Publication of Banns",style: TextStyle(fontSize: 20),),
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
              child:Text("BrideGroom ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
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
                   labelText: "Bridegroom's name & surname" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.groomname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.groomname= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Bridegroom's name & surname";
    }
    else{
      setState(() {
 marriage.groomname=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Names of his parents" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.groomparents = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.groomparents = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Names of his parents";
    }
    else{
      setState(() {
  marriage.groomparents=value;
      });
    }
                    },
                  ),
     
               TextFormField(
                controller: _dateController, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Baptism Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(

                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now()
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateController.text = formattedDate;
                        
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
             setState(() {
        marriage.groombaptism=value;
      });
                },
                onSaved: (value){
                   print(value);
                },
                    validator: (value) {
                
                       if (value == null || value.isEmpty) {
      return 'Select Date Of Baptism.';
    }
    else{
      setState(() {
        marriage.groombaptism=value;
      });
    }
                    },
             ),
           
          TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Place of his Baptism" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.groombaptismplace = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.groombaptismplace = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Place of his baptism .";
    }
    else{
      setState(() {
 marriage.groombaptismplace=value;
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
              child:Text("Bride ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
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
                   labelText: "Bride's name & Surname" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.bridename = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.bridename= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Bride's name & Surname";
    }
    else{
      setState(() {
 marriage.bridename=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Names of her parents " //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.brideparents= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.brideparents=value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Bride's Parents name";
    }
    else{
      setState(() {
  marriage.brideparents=value;
      });
    }
                    },
                  ),
     
               TextFormField(
                controller: _dateControllerbride, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Baptism Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(

                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now()
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateControllerbride.text = formattedDate;
                        
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
             setState(() {
        marriage.bridebaptism=value;
      });
                },
                onSaved: (value){
                   print(value);
                },
                    validator: (value) {
                
                       if (value == null || value.isEmpty) {
      return 'Select Date Of Birth.';
    }
    else{
      setState(() {
        marriage.bridebaptism=value;
      });
    }
                    },
             ),
           
          TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Place of her baptism" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.bridebaptismplace = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.bridebaptismplace = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter baptised church name .";
    }
    else{
      setState(() {
 marriage.bridebaptismplace=value;
      });
    }
                    },
                  ),

   
          
   
           
      ],
      
    ),



 verticalSpaceRegular,
            // ignore: prefer_const_constructors
            if(_isbutton)...[ Align(
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
                  ),),],
            verticalSpaceRegular,
        
      ]) );}) ],));
      
  }
 
}
