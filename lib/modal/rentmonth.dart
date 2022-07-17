// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class RentMonth {
int? _id;
  String? _rent_name;
  String? _rent_namemalayalam;
  String? _userid;
  String? _room_no;
  String? _building;
  String? _month;
  String? _rentpayed;
  String? _total_due;
  String? _monthlyrent;
  String? _rentperyear;
  String? _year;
  String? _prev_due;
  String? _total_rentpayed;

   

  


  RentMonth(
  this._rent_name, 
  this._rent_namemalayalam,
  this._userid,
  this._room_no, 
  this._building,
this._month,
  this._rentpayed,
  this._total_due,
  this._monthlyrent,
  this._rentperyear,
  this._year,
  this._prev_due,
  this._total_rentpayed);

RentMonth.withId(
  this._id,
  this._rent_name, 
  this._rent_namemalayalam,
  this._userid,
  this._room_no, 
  this._building,
  this._month,
  this._rentpayed,
  this._total_due,
  this._monthlyrent,
  this._rentperyear,
  this._year,
  this._prev_due,
  this._total_rentpayed);

  int? get id => _id;
  String get rentname => _rent_name??"";
  String get rentnamemalayalam => _rent_namemalayalam??"";
  String get userid => _userid??"";
  String get roomno => _room_no??"";
  String get building => _building??"";
  String get month => _month??"";
  String get rentpayed => _rentpayed??"";
 
  String get totaldue => _total_due??"";
  String get monthlyrent => _monthlyrent??"";
  String get rentperyear => _rentperyear??"";
  String get year => _year??"";
  String get prevdue => _prev_due??"";
  String get totalrentpayed => _total_rentpayed??"";
 
  set rentname(String newrent_name) {
    if (newrent_name.length <= 255) {
      this._rent_name = newrent_name;
    }
  }

  set rentnamemalayalam(String newrent_namemalayalam) {
    if (newrent_namemalayalam.length <= 255) {
      this._rent_namemalayalam = newrent_namemalayalam;
    }
  }
set userid(String newData) {
    this._userid = newData;
  }
  set roomno(String newroom_no) {
    if (newroom_no.length <= 255) {
      this._room_no = newroom_no;
    }
  }

  set building(String newbuildingname) {
    if (newbuildingname.length <= 255) {
      this._building = newbuildingname;
    }
  }

  set MonthPicker(String newMonth) {
    this._month = newMonth;
  }
    set rentpayed(String rentpayed) {
    this._rentpayed = rentpayed;
  }
   
   set totaldue(String newData) {
    this._total_due = newData;
  }
     set monthlyrent(String newData) {
    this._monthlyrent = newData;
  }
     set rentperyear(String newData) {
    this._rentperyear = newData;
  }
     set year(String newData) {
    this._year = newData;
  }
     set prevdue(String newData) {
    this._prev_due = newData;
  }
     set totalrentpayed(String newData) {
    this._total_rentpayed = newData;
  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
     if (id != null) {
      map['id'] = _id;
    }
    map['rent_name'] = _rent_name;
    map['rent_namemalayalam'] = _rent_namemalayalam;
    map['user_id'] = _userid;
    map['room_no'] = _room_no;
    map['building'] = _building;
    map['month'] =_month;
map['rentpayed'] =_rentpayed;
  map['total_due'] = _total_due;
  map['monthlyrent'] = _monthlyrent;
  map['rentperyear'] = _rentperyear;
  map['year'] = _year;
  map['prev_due'] = _prev_due;
  map['total_rentpayed'] = _total_rentpayed;
 
    return map;
  }

  // Extract a Note object from a Map object
  
  RentMonth.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
  this._rent_name = map['rent_name'];
  this._rent_namemalayalam = map['rent_namemalayalam'] ;
  this._userid = map['user_id'] ;
  this._room_no = map['room_no'] ;
  this._building = map['building'] ;
  this._month =  map['month'] ;
  this._rentpayed = map['rentpayed'] ;
this._total_due = map['total_due']  ;
this._monthlyrent = map['monthlyrent'] ;
this._rentperyear = map['rentperyear'];
this._year = map['year'];
this._prev_due = map['prev_due'] ;
this._total_rentpayed = map['total_rentpayed'];
  }
}


class Addrent{
int? _id;
  String? _userid;
  String? _rent;
  String? _month;
  String? _year;
Addrent(
  this._userid, 
  this._rent,
  this._month,
  this._year);

Addrent.withId(
  this._userid, 
  this._rent,
  this._month,
  this._year);

  int? get id => _id;
  String get userid => _userid??"";
  String get rent => _rent??"";
  String get month => _month??"";
  String get year => _year??"";

 


set userid(String newData) {
    this._userid = newData;
  }
  set rent(String rent) {
    this._rent = rent;
  }
  set month(String month) {
    if (month.length <= 255) {
      this._month = month;
    }
  }
  set year(String year) {
    if (year.length <= 255) {
      this._year = year;
    }
  }




  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
     if (id != null) {
      map['id'] = _id;
    }
    map['userid'] = _userid;
    map['rent'] = _rent;
    map['month'] = _month;
    map['year'] = _year;
    
    return map;
  }

  // Extract a Note object from a Map object
  
  Addrent.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
  this._userid = map['userid'];
  this._rent = map['rent'] ;
  this._month = map['month'] ;
  this._year = map['year'] ;
  
  }


}

class Editrentuser{
int? _id;
  String? _userid;
  String? _rentname;
  String? _rentnamemalayalam;
  String? _room;
  String? _rent;
  String? _building;
    String? _phone;

Editrentuser(
  this._userid, 
  this._rentname,
 this._rentnamemalayalam,
  this._room,
  this._rent,
  this._building,
  this._phone,
);

Editrentuser.withId(
    this._userid, 
  this._rentname,
 this._rentnamemalayalam,
  this._room,
  this._rent,
  this._building,
  this._phone,);

  int? get id => _id;
  String get userid => _userid??"";
  String get rentname => _rentname??"";
  String get rentnamemalayalam => _rentnamemalayalam??"";
  String get room => _room??"";
   String get rent => _rent??"";
  String get building => _building??"";
String get phone => _phone??"";

 


set userid(String newData) {
    this._userid = newData;
  }
  set rentname(String rentname) {
    this._rentname = rentname;
  }
  set rentnamemalayalam(String rentnamemalayalam) {
    if (rentnamemalayalam.length <= 255) {
      this._rentnamemalayalam = rentnamemalayalam;
    }
  }
  set room(String room) {
    if (room.length <= 255) {
      this._room = room;
    }
  }
    set rent(String rent) {
    if (rent.length <= 255) {
      this._rent = rent;
    }
  }
    set building(String building) {
    if (building.length <= 255) {
      this._building = building;
    }
  }

  set phone(String phone) {
    if (phone.length <= 255) {
      this._phone = phone;
    }

  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
     if (id != null) {
      map['id'] = _id;
    }
    map['userid'] = _userid;
map['userid'] =_rentname;
 map['userid'] =_rentnamemalayalam;
  map['userid'] =_room;
   map['userid'] =_rent;
  map['userid'] =_building;
map['userid'] =_phone;
    
    return map;
  }

  // Extract a Note object from a Map object
  
  Editrentuser.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
  this._userid = map['userid'];

  this._rentname = map['rentname'];
 this._rentnamemalayalam = map['rentnamemalayalam'];
  this._room = map['room'];
  this._rent = map['_rent'];
  this._building = map['building'];
  this._phone = map['phone'];
  
  }


}