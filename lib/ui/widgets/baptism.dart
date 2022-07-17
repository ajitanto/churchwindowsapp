

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print

import 'package:church_windows/modal/demo.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';


class BaptismForm extends StatefulWidget {
final String? formtype;
   BaptismForm({Key? key,this.formtype}) : super(key: key);

  @override
  State<BaptismForm> createState() => _BaptismFormState();
}

class _BaptismFormState extends State<BaptismForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late BaptimsFormList _baptism;


  String? formatted;
    TextEditingController _dateController = TextEditingController();
     TextEditingController _datebaptismController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool _isbutton=true;
  @override
 void initState() {
   super.initState();
final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  setState(() {
  
   _baptism = BaptimsFormList("", "", "", "", "", "", "", "", "", "", "", "");
  });
  setState(() {
formatted = formatter.format(now);

_baptism.dob="jhjhj";
print(_baptism.dob);
 
  });
  
 }
 void createcerti(BuildContext context,BaptimsFormList _baptism){
    setState(() {
    _isbutton=false;
  });
    Createcertificate.createBaptism(context,_baptism).then((value) {
     if(value=="Success"){
      setState(() {

       _isbutton=true;
       _formKey.currentState?.reset();
      _dateController.text = "";
_datebaptismController.text = "";

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
        
     Text("Baptism Certificate",style: TextStyle(fontSize: 25),),
     verticalSpaceRegular,
LayoutBuilder(
                  builder: (ctx, constrain) {
     return Form(

        key:_formKey ,
        child:
 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [
   TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Reference No. on the Register" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.refno = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.refno = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Reference No. on the Register";
    }
    else{
      setState(() {
 _baptism.refno=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Baptism Name" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.baptismname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.baptismname = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Baptism name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'Baptism name cannot contain special characters';
                      }
                    },
                  ),
              TextFormField(
                controller: _dateController, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Date Of Birth" //label text of field
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
                  print(value);
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
        _baptism.dob=value;
      });
    }
                    },
             ),
           
      TextFormField(
                controller: _datebaptismController, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Date Of Baptism" //label text of field
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
                         _datebaptismController.text = formattedDate;
                        _baptism.dobaptism=formattedDate;
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
                  print(value);
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
 _baptism.dobaptism=value;
      });
    }
                    },
             ),
                  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Father's name, Surname & Rite" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.fsrname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.fsrname = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter  Father's name, Surname & Rite .";
    }
    else{
      setState(() {
 _baptism.fsrname=value;
      });
    }
                    },
                  ),
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Mother's name, Surname" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.msname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.msname = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Mother's name, Surname.";
    }
    else{
      setState(() {
 _baptism.msname=value;
      });
    }
                    },
                  ),
          
            TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Father's abode at Baptism" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.abodebaptism = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.abodebaptism = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Father's abode at Baptism.";
    }
    else{
      setState(() {
 _baptism.abodebaptism=value;
      });
    }
                    },
                  ),
          
            TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Godfather, with abode" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.gfatherabode = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.gfatherabode = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Godfather, with abode";
    }
    else{
      setState(() {
 _baptism.gfatherabode=value;
      });
    }
                    },
                  ),
          
              TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Godmother, with abode" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.gmotherabode = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.gmotherabode = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Godmother, with abode";
    }
    else{
      setState(() {
 _baptism.gmotherabode=value;
      });
    }
                    },
                  ),

        
         TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Minister of Baptism" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _baptism.ministerofbaptism = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _baptism.ministerofbaptism = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Minister of Baptism";
    }
    else{
      setState(() {
 _baptism.ministerofbaptism=value;
      });
    }
                    },
                  ),    // TextFormField(
            //         decoration: const InputDecoration(
            //             labelText: 'Body Temperature',
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //               borderSide:
            //                   BorderSide(color: Colors.grey, width: 0.0),
            //             ),
            //             border: OutlineInputBorder()),
            //         keyboardType: TextInputType.number,
            //         validator: (value) {
            //           if (value == null ||
            //               value.isEmpty ||
            //               value.contains(RegExp(r'^[a-zA-Z\-]'))) {
            //             return 'Use only numbers!';
            //           }
            //         },
            //         onFieldSubmitted: (value) {
            //           setState(() {
            //             bodyTemp = value;
            //             // bodyTempList.add(bodyTemp);
            //           });
            //         },
            //         onChanged: (value) {
            //           setState(() {
            //             bodyTemp = value;
            //           });
            //         },
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       DropdownButtonFormField(
            //           decoration: const InputDecoration(
            //               enabledBorder: OutlineInputBorder(
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(20.0)),
            //                 borderSide:
            //                     BorderSide(color: Colors.grey, width: 0.0),
            //               ),
            //               border: OutlineInputBorder()),
            //           // ignore: prefer_const_literals_to_create_immutables
            //           items: [
            //             const DropdownMenuItem(
            //               child: Text("ºC"),
            //               value: 1,
            //             ),
            //             const DropdownMenuItem(
            //               child: Text("ºF"),
            //               value: 2,
            //             )
            //           ],
            //           hint: const Text("Select item"),
            //           onChanged: (value) {
            //             setState(() {
            //               measure = value;
            //               // measureList.add(measure);
            //             });
            //           },
            //           onSaved: (value) {
            //             setState(() {
            //               measure = value;
            //             });
            //           }),
            //       const SizedBox(
            //         height: 20,
            //       ),
                  // ignore: deprecated_member_use
                if(_isbutton)...[  FlatButton(
                  
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isbutton=false;
                        });
                     createcerti(context,_baptism);
                      }
                    },
                    child: const Text("Submit"),
                  )],
           
      ],
      
    ),
       );}) ],));
      
  }
 
}
