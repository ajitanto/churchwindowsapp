
// add the http plugin in pubspec.yaml file.
// import 'Employee.dart';

// ignore_for_file: avoid_print, prefer_is_empty, unnecessary_new, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:church_windows/datacontroller/datahandler.dart';
import 'package:church_windows/modal/rentusercsv.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class Services {

  static Future<String> rentUSerCsvs() async {
    // var login_url = BASE_URL + "/unit_api";
 
    List<RentuserCsv> _rentusercsv =[];
    RentuserCsv usercsv;

  
      int i,j;
 String json='[';

FilePickerResult? result = await FilePicker.platform.pickFiles();
if(result !=null){

  

final input = new File(result.files.single.path.toString()).openRead();
final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
for(i=1;i<fields.length;i++){
json+="{";
for(j=0;j<fields[i].length;j++){


if(j==(fields[i].length-1)){
  json+='"'+fields[0][j]+'":"'+fields[i][j].toString()+'"';
}
else{
  json+='"'+fields[0][j]+'":"'+fields[i][j].toString()+'",';
}


}
if(i==(fields.length-1)){
json+="}";
}else{
json+="},";
}
// json+='{"rent_name":"'+fields[i][0].toString()+'","rent_namemalayalam":"'+fields[i][1].toString()+'","room_no":"'+fields[i][2].toString()+'","building":"'+fields[i][3].toString()+'","rent":"'+fields[i][4].toString()+'","phone":"'+fields[i][5].toString()+'","type":"'+fields[i][6].toString()+'"},';

// if(i==(fields.length-1)){
// json+='{"rent_name":"'+fields[i][0].toString()+'","rent_namemalayalam":"'+fields[i][1].toString()+'","room_no":"'+fields[i][2].toString()+'","building":"'+fields[i][3].toString()+'","rent":"'+fields[i][4].toString()+'","phone":"'+fields[i][5].toString()+'","type":"'+fields[i][6].toString()+'"}';
// }
}
json+="]";

List<dynamic> jsondecode = jsonDecode(json);
print(jsondecode.length);

   if (jsondecode.length > 0) {
          for (int k = 0; k < jsondecode.length; k++) {
            if (jsondecode[k] != null) {
              Map<String, dynamic> map = jsondecode[k];

 _rentusercsv.add(RentuserCsv.fromMapObject(map));
      
            usercsv = RentuserCsv.fromMapObject(map);
              var isLoggedIn = await DBProvider.db.loginstatusarg(usercsv.rentname,usercsv.roomno,usercsv.building,usercsv.rent,usercsv.status,usercsv.rentstartedmonth,usercsv.rentstartedyear);
              if (isLoggedIn) {
                print('already added');
              }
              else{
            DBProvider.db.createAuth(usercsv);
              }


            }
   
          }
   
        print(_rentusercsv.first.rentname);

        return "Success";
      } else {
        return "error";
      }
}
else{
  return "error";
}

    }
  
}
