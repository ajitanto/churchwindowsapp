// ignore_for_file: unnecessary_this

class RentuserCsv {
int? _id;
  String? _rent_name;
  String? _rent_namemalayalam;
  String? _room_no;
  String? _building;
  String? _rent;
  String? _phone;
  String? _type;
   String? _prev_due;
   String? _status;
  String? _rentstartedyear;
   String? _rentstartedmonth;
  RentuserCsv(this._rent_name, this._rent_namemalayalam, this._room_no, this._building,
      this._rent, this._phone, this._type,this._prev_due,this._status,this._rentstartedmonth,this._rentstartedyear);

RentuserCsv.withId(this._id,this._rent_name, this._rent_namemalayalam, this._room_no, this._building,
      this._rent, this._phone, this._type,this._prev_due,this._status,this._rentstartedmonth,this._rentstartedyear);

  int? get id => _id;
  String get rentname => _rent_name??"";

  String get rentnamemalayalam => _rent_namemalayalam??"";

  String get roomno => _room_no??"";
  String get building => _building??"";
  String get rent => _rent??"";
  String get phone => _phone??"";
  String get type => _type??"";
   String get prevdue => _prev_due??"";
    String get status => _status??"";
      String get rentstartedyear => _rentstartedyear??"";
    String get rentstartedmonth=> _rentstartedmonth??"";
 
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

  set rent(String newrent) {
    this._rent = newrent;
  }

  set phone(String newphone) {
    this._phone = newphone;
  }

  set type(String newtype) {
    this._type = newtype;
  }
    set prevdue(String newtype) {
    this._prev_due = newtype;
  }
    set status(String newtype) {
    this._status = newtype;
  }
  
    set rentstartedyear(String newtype) {
    this._rentstartedyear = newtype;
  }
     set rentstartedmonth(String newtype) {
    this._rentstartedmonth = newtype;
  }
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
     if (id != null) {
      map['id'] = _id;
    }
    map['rent_name'] = _rent_name;
    map['rent_namemalayalam'] = _rent_namemalayalam;
    map['room_no'] = _room_no;
    map['building'] = _building;
    map['rent'] = _rent;
    map['phone'] = _phone;
    map['type'] = _type;
  map['prev_due'] = _type;
   map['status'] = _status;
   map['rentstartedyear'] = _rentstartedyear;
    map['rentstartedmonth'] = _rentstartedmonth;
    return map;
  }

  // Extract a Note object from a Map object
  
  RentuserCsv.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
    this._rent_name = map['rent_name'];
    this._rent_namemalayalam = map['rent_namemalayalam'];
    this._room_no = map['room_no'];
    this._building = map['building'];
    this._rent = map['rent'];
    this._phone = map['phone'];
    this._type = map['type'];
 this._prev_due = map['prev_due'];
  this._status = map['status'];
 this._rentstartedyear = map['rentstartedyear'];
  this._rentstartedmonth = map['rentstartedmonth'];
  }
}
