

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print, prefer_const_constructors



import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/services/editword.dart';
import 'package:cool_alert/cool_alert.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';


class MarriageForm extends StatefulWidget {
final String? formtype;
   MarriageForm({Key? key,this.formtype}) : super(key: key);

  @override
  State<MarriageForm> createState() => _MarriageFormState();
}

class _MarriageFormState extends State<MarriageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Marriage marriage;
bool _isLoading=false;
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
  
   marriage = Marriage("", "", "", "", "", "", "", "", "", "","","","","","","","","","");
  });
  setState(() {
formatted = formatter.format(now);

  });
  
 }
 void createcerti(BuildContext context,Marriage _marriage){
   setState(() {
     _isLoading=true;
     _isbutton=false;
   });
    Createcertificate.createMarriage(context,_marriage ).then((value) {
     if(value=="Success"){
      setState(() {
        _isLoading=false; 
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
        _isLoading=false;
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
     Text("Marriage Certificate",style: TextStyle(fontSize: 25),),
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
                   labelText: "Full Name" //label text of field
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
      return "Enter Groom name";
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
                   labelText: "Son of" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.groomsonof = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.groomsonof = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Groom's Parents name";
    }
    else{
      setState(() {
  marriage.groomsonof=value;
      });
    }
                    },
                  ),
     
               TextFormField(
                controller: _dateController, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Born On" //label text of field
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
        marriage.groombornon=value;
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
        marriage.groombornon=value;
      });
    }
                    },
             ),
           
          TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Baptized in the Church of" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.groombapt = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.groombapt = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter baptised church name .";
    }
    else{
      setState(() {
 marriage.groombapt=value;
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
                        marriage.groomdatebapt=formattedDate;
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
               marriage.groomdatebapt=value;
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
marriage.groomdatebapt=value;
      });
    }
                    },
             ),
       
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Residing at" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.groomres = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.groomres = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Residing at";
    }
    else{
      setState(() {
marriage.groomres=value;
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
                   labelText: "Full Name" //label text of field
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
      return "Enter Bride name";
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
                   labelText: "Daughter of" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.bridedaught= value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.bridedaught = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Bride's Parents name";
    }
    else{
      setState(() {
  marriage.bridedaught=value;
      });
    }
                    },
                  ),
     
               TextFormField(
                controller: _dateControllerbride, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Born On" //label text of field
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
        marriage.bridebornon=value;
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
        marriage.bridebornon=value;
      });
    }
                    },
             ),
           
          TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Baptized in the Church of" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      marriage.bridebapt = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        marriage.bridebapt = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter baptised church name .";
    }
    else{
      setState(() {
 marriage.bridebapt=value;
      });
    }
                    },
                  ),

                   TextFormField(
                controller: _datebaptismControllerbride, //editing controller of this TextField
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
                         _datebaptismControllerbride.text = formattedDate;
                        marriage.bridedatebapt=formattedDate;
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
               marriage.bridedatebapt=value;
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
marriage.bridedatebapt=value;
      });
    }
                    },
             ),
       
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Residing at" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.brideres = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.brideres = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Residing at";
    }
    else{
      setState(() {
marriage.brideres=value;
      });
    }
                    },
                  ),
          
   
           
      ],
      
    ),

     verticalSpaceRegular,

                Align(
              alignment:Alignment.topLeft,
              child:Text("Holy Matrimony Details ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
            ),verticalSpaceRegular,
 ResponsiveGridList(
      maxItemsPerRow:constrain.isExtraLarge? 3:constrain.isLarge?2:constrain.isMedium?2:constrain.isSmall?2:constrain.isExtraSmall?1:1,
      minItemsPerRow: 1,
       shrinkWrap: true,
                        minItemWidth: 100,
                        children: [
  
                   TextFormField(
                controller: _datemarriageController, //editing controller of this TextField
                decoration: const InputDecoration( 
                    //icon of text field
                   labelText: "Date Of Marriage" //label text of field
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
                         _datemarriageController.text = formattedDate;
                        marriage.dateofmarriage=formattedDate;
                    //  baptism?.dob= _dateController.text;
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onFieldSubmitted: (value){
               marriage.dateofmarriage=value;
                },
                onSaved: (value){
                   print(value);
                },
                    validator: (value) {
                
                       if (value == null || value.isEmpty) {
      return 'Select Date Of Marriage.';
    }
    else{
      setState(() {
marriage.dateofmarriage=value;
      });
    }
                    },
             ),
       
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Church Name" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.church = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.church = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Church name";
    }
    else{
      setState(() {
marriage.church=value;
      });
    }
                    },
                  ),
          
             
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Witness 1" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.witness1 = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.witness1 = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Witness name";
    }
    else{
      setState(() {
marriage.witness1=value;
      });
    }
                    },
                  ),

                            
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Witness2" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.witness2 = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.witness2 = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Name of Witness 2";
    }
    else{
      setState(() {
marriage.witness2=value;
      });
    }
                    },
                  ),

                            
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Celebrant of Marriage" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     marriage.celebrant = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       marriage.celebrant = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Celebrant name";
    }
    else{
      setState(() {
marriage.celebrant=value;
      });
    }
                    },
                  ),
           
      ],
      
    ),
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
                          _isbutton=false;
                        });
                     createcerti(context,marriage);
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
