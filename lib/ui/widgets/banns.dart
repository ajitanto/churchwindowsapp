

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


class BannsForm extends StatefulWidget {
final String? formtype;
   BannsForm({Key? key,this.formtype}) : super(key: key);

  @override
  State<BannsForm> createState() => _BannsFormState();
}

class _BannsFormState extends State<BannsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 late Banns _banns;


  String? formatted;
  bool _isbutton=true;
    TextEditingController _dateController = TextEditingController();
     TextEditingController _datebaptismController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
 void initState() {
   super.initState();
final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  setState(() {
  
   _banns = Banns("", "", "", "", "", "", "", "", "", "");
  });
  setState(() {
formatted = formatter.format(now);

  });
  
 }
 void createcerti(BuildContext context,Banns _banns){
    setState(() {
    _isbutton=false;
  });
    Createcertificate.createBanns(context,_banns ).then((value) {
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
        
     // ignore: prefer_const_constructors
     Text("Marriage Banns ( before Betrothal)",style: TextStyle(fontSize: 25),),
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
                      _banns.groomname = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _banns.groomname= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Groom name";
    }
    else{
      setState(() {
 _banns.groomname=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "House name" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _banns.groomhousename = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _banns.groomhousename = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Groom House name";
    }
    else{
      setState(() {
  _banns.groomhousename=value;
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
                      _banns.groomparents = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                         _banns.groomparents = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Name of Parents .";
    }
    else{
      setState(() {
  _banns.groomparents=value;
      });
    }
                    },
                  ),
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Parish" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     _banns.groomparish = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       _banns.groomparish = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Parish of bridegroom";
    }
    else{
      setState(() {
_banns.groomparish=value;
      });
    }
                    },
                  ),
          
            TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Diocese" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _banns.groomdiocese = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       _banns.groomdiocese = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Diocese of Groom";
    }
    else{
      setState(() {
 _banns.groomdiocese=value;
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
                      _banns.bridename = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _banns.bridename= value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Bride name";
    }
    else{
      setState(() {
 _banns.bridename=value;
      });
    }
                    },
                  ),
               TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "House name" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _banns.bridehousename = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                        _banns.bridehousename = value;
                      });
                    },
                    validator: (value) {
                              if (value == null || value.isEmpty) {
      return "Enter Bride House name";
    }
    else{
      setState(() {
  _banns.bridehousename=value;
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
                      _banns.brideparents = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                         _banns.brideparents = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Name of Parents .";
    }
    else{
      setState(() {
  _banns.brideparents=value;
      });
    }
                    },
                  ),
          
  TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Parish" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                     _banns.brideparish = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       _banns.brideparish = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Parish of bride";
    }
    else{
      setState(() {
_banns.brideparish=value;
      });
    }
                    },
                  ),
          
            TextFormField(
                   decoration: const InputDecoration( 
               //icon of text field
                   labelText: "Diocese" //label text of field
                ),
                    onFieldSubmitted: (value) {
                      setState(() {
                      _banns.bridediocese = value;
                        // firstNameList.add(firstName);
                      });
                    },
                
                    onChanged: (value) {
                      setState(() {
                       _banns.bridediocese = value;
                      });
                    },
                    validator: (value) {
                     if (value == null || value.isEmpty) {
      return "Enter Diocese of Bride";
    }
    else{
      setState(() {
 _banns.bridediocese=value;
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
                     createcerti(context,_banns);
                      }
                    },
                    child: const Text("Submit"),
                  ),)],
            verticalSpaceRegular,
        
      ]) );}) ],));
      
  }
 
}
