// ignore_for_file: unnecessary_this

class BaptimsFormList {

  String _date;
  String _church;
  String _refno;
  String _baptismname;
  String _dob;
  String _dobaptism;
  String _fsrname;
  String _msname;
  String _abodebaptism;
  String _gfatherabode;
  String _gmotherabode;
  String _ministerofbaptism;
 
  BaptimsFormList(
 this._date,
  this._church,
  this._refno,
  this._baptismname,
  this._dob,
  this._dobaptism,
  this._fsrname,
  this._msname,
  this._abodebaptism,
  this._gfatherabode,
  this._gmotherabode,
  this._ministerofbaptism);


   String get date => _date;
  String get church => _church;
  String get refno => _refno;
  String get baptismname => _baptismname;
  String get dob => _dob;
  String get dobaptism => _dobaptism;
  String get fsrname => _fsrname;
  String get msname => _msname;
  String get abodebaptism => _abodebaptism;
  String get gfatherabode => _gfatherabode;
  String get gmotherabode => _gmotherabode;
  String get ministerofbaptism => _ministerofbaptism;
 
  set date(String newText) {
    if (date.length <= 255) {
      this._date = newText;
    }
  }
  set church(String newText) {
    if (date.length <= 255) {
      this._church = newText;
    }
  }
  set refno(String newText) {
    if (refno.length <= 255) {
      this._refno = newText;
    }
  }
   set baptismname(String newText) {
    if (baptismname.length <= 255) {
      this._baptismname = newText;
    }
  }
    set dob(String newText) {
    if (dob.length <= 255) {
      this._dob = newText;
    }
  }
 set dobaptism(String newText) {
    if (dobaptism.length <= 255) {
      this._dobaptism = newText;
    }
  }
   set fsrname(String newText) {
    if (fsrname.length <= 255) {
      this._fsrname = newText;
    }
  }
   set msname(String newText) {
    if (msname.length <= 255) {
      this._msname = newText;
    }
  }
     set abodebaptism(String newText) {
    if (abodebaptism.length <= 255) {
      this._abodebaptism = newText;
    }
  }
     set gfatherabode(String newText) {
    if (gfatherabode.length <= 255) {
      this._gfatherabode = newText;
    }
  }
       set gmotherabode(String newText) {
    if (gmotherabode.length <= 255) {
      this._gmotherabode = newText;
    }
  }
   
         set ministerofbaptism(String newText) {
    if (ministerofbaptism.length <= 255) {
      this._ministerofbaptism = newText;
    }
  }
}
class Banns{
 String _groomname;
 String _groomhousename;
 String _groomparents;
 String _groomparish;
 String _groomdiocese;
 String _bridename;
 String _bridehousename;
 String _brideparents;
 String _brideparish;
 String _bridediocese;

 Banns(this._groomname, this._groomhousename, this._groomparents, this._groomparish, this._groomdiocese, this._bridename, this._bridehousename, this._brideparents, this._brideparish, this._bridediocese);





  String get groomname => _groomname;

  set groomname(String groomname) {
    this._groomname = groomname;
  }

  String get groomhousename => _groomhousename;

  set groomhousename(String groomhousename) {
    this._groomhousename = groomhousename;
  }


  String get groomparents => _groomparents;

  set groomparents(String groomparents) {
    this._groomparents = groomparents;
  }


  String get groomparish => _groomparish;

  set groomparish(String groomparish) {
    this._groomparish = groomparish;
  }


  String get groomdiocese => _groomdiocese;

  set groomdiocese(String groomdiocese) {
    this._groomdiocese = groomdiocese;
  }
 

  String get bridename => _bridename;

  set bridename(String bridename) {
    this._bridename = bridename;
  }


  String get bridehousename => _bridehousename;

  set bridehousename(String bridehousename) {
    this._bridehousename = bridehousename;
  }


  String get brideparents => _brideparents;

  set brideparents(String brideparents) {
    this._brideparents = brideparents;
  }


  String get brideparish => _brideparish;

  set brideparish(String brideparish) {
    this._brideparish = brideparish;
  }


  String get bridediocese => _bridediocese;

  set bridediocese(String bridediocese) {
    this._bridediocese = bridediocese;
  }

}

class Marriage{
  
    String _groomname;
 String _groomsonof;
   String _groombornon;
  String _groombapt;
 String _groomdatebapt;
 String _groomres;
 String _bridename;
 String _bridedaught;
 String _bridebornon;
 String _bridebapt;
 String _bridedatebapt;
 String _brideres;
 String _dateofmarriage;
 String _church;
 String _witness1;
 String _witness2;
 String _celebrant;
 String _place;
 String _date;

  Marriage(this._groomname, this._groomsonof, this._groombornon, this._groombapt, this._groomdatebapt, this._groomres, this._bridename, this._bridedaught, this._bridebornon, this._bridebapt, this._bridedatebapt, this._brideres, this._dateofmarriage, this._church, this._witness1, this._witness2, this._celebrant, this._place, this._date);

 
  

  String get groomname => _groomname;

  set groomname(String groomname) {
    this._groomname = groomname;
  }


  String get groomsonof => _groomsonof;

  set groomsonof(String groomsonof) {
    this._groomsonof = groomsonof;
  }


  String get groombornon => _groombornon;

  set groombornon(String groombornon) {
    this._groombornon = groombornon;
  }


  String get groombapt => _groombapt;

  set groombapt(String groombapt) {
    this._groombapt = groombapt;
  }


  String get groomdatebapt => _groomdatebapt;

  set groomdatebapt(String groomdatebapt) {
    this._groomdatebapt = groomdatebapt;
  }


  String get groomres => _groomres;

  set groomres(String groomres) {
    this._groomres = groomres;
  }

  String get bridename => _bridename;

  set bridename(String bridename) {
    this._bridename = bridename;
  }


  String get bridedaught => _bridedaught;

  set bridedaught(String bridedaught) {
    this._bridedaught = bridedaught;
  }


  String get bridebornon => _bridebornon;

  set bridebornon(String bridebornon) {
    this._bridebornon = bridebornon;
  }


  String get bridebapt => _bridebapt;

  set bridebapt(String bridebapt) {
    this._bridebapt = bridebapt;
  }


  String get bridedatebapt => _bridedatebapt;

  set bridedatebapt(String bridedatebapt) {
    this._bridedatebapt = bridedatebapt;
  }
 

  String get brideres => _brideres;

  set brideres(String brideres) {
    this._brideres = brideres;
  }
 

  String get dateofmarriage => _dateofmarriage;

  set dateofmarriage(String dateofmarriage) {
    this._dateofmarriage = dateofmarriage;
  }


  String get church => _church;

  set church(String church) {
    this._church = church;
  }


  String get witness1 => _witness1;

  set witness1(String witness1) {
    this._witness1 = witness1;
  }
 

  String get witness2 => _witness2;

  set witness2(String witness2) {
    this._witness2 = witness2;
  }


  String get celebrant => _celebrant;

  set celebrant(String celebrant) {
    this._celebrant = celebrant;
  }
 

  String get place => _place;

  set place(String place) {
    this._place = place;
  }


  String get date => _date;

  set date(String date) {
    this._date = date;
  }

  
}
class Marriage3{



String _groomname;
String _groomparents;
String _groombaptism;
String _groombaptismplace;
String _bridename;
String _brideparents;
String _bridebaptism;
String _bridebaptismplace;
String _noofbanns;
String _parish;
String _place;
String _date;


  Marriage3(this._groomname, this._groomparents, this._groombaptism, this._groombaptismplace, this._bridename, this._brideparents, this._bridebaptism, this._bridebaptismplace, this._noofbanns, this._parish, this._place, this._date);



  String get groomname => _groomname;

  set groomname(String groomname) {
    this._groomname = groomname;
  }


  String get groomparents => _groomparents;

  set groomparents(String groomparents) {
    this._groomparents = groomparents;
  }


  String get groombaptism => _groombaptism;

  set groombaptism(String groombaptism) {
    this._groombaptism = groombaptism;
  }


  String get groombaptismplace => _groombaptismplace;

  set groombaptismplace(String groombaptismplace) {
    this._groombaptismplace = groombaptismplace;
  }


  String get bridename => _bridename;

  set bridename(String bridename) {
    this._bridename = bridename;
  }


  String get brideparents => _brideparents;

  set brideparents(String brideparents) {
    this._brideparents = brideparents;
  }


  String get bridebaptism => _bridebaptism;

  set bridebaptism(String bridebaptism) {
    this._bridebaptism = bridebaptism;
  }

  String get bridebaptismplace => _bridebaptismplace;

  set bridebaptismplace(String bridebaptismplace) {
    this._bridebaptismplace = bridebaptismplace;
  }


  String get noofbanns => _noofbanns;

  set noofbanns(String noofbanns) {
    this._noofbanns = noofbanns;
  }


  String get parish => _parish;

  set parish(String parish) {
    this._parish = parish;
  }


  String get place => _place;

  set place(String place) {
    this._place = place;
  }


  String get date => _date;

  set date(String date) {
    this._date = date;
  }


}


class Marriage4{



String _groomname;
String _groomparents;
String _groomreligion;
String _groombaptism;
String _groombaptismplace;
String _bridename;
String _brideparents;
String _bridereligion;
String _bridebaptism;
String _bridebaptismplace;
String _parish;
String _place;
String _date;


  Marriage4(this._groomname, this._groomparents,this._groomreligion, this._groombaptism, this._groombaptismplace, this._bridename, this._brideparents, this._bridereligion, this._bridebaptism, this._bridebaptismplace, this._parish, this._place, this._date);



  String get groomname => _groomname;

  set groomname(String groomname) {
    this._groomname = groomname;
  }


  String get groomparents => _groomparents;

  set groomparents(String groomparents) {
    this._groomparents = groomparents;
  }

 String get groomreligion => _groomreligion;

  set groomreligion(String groomreligion) {
    this._groomreligion = groomreligion;
  }


  String get groombaptism => _groombaptism;

  set groombaptism(String groombaptism) {
    this._groombaptism = groombaptism;
  }


  String get groombaptismplace => _groombaptismplace;

  set groombaptismplace(String groombaptismplace) {
    this._groombaptismplace = groombaptismplace;
  }


  String get bridename => _bridename;

  set bridename(String bridename) {
    this._bridename = bridename;
  }


  String get brideparents => _brideparents;

  set brideparents(String brideparents) {
    this._brideparents = brideparents;
  }

String get bridereligion => _bridereligion;

  set bridereligion(String bridereligion) {
    this._bridereligion = bridereligion;
  }

  String get bridebaptism => _bridebaptism;

  set bridebaptism(String bridebaptism) {
    this._bridebaptism = bridebaptism;
  }

  String get bridebaptismplace => _bridebaptismplace;

  set bridebaptismplace(String bridebaptismplace) {
    this._bridebaptismplace = bridebaptismplace;
  }




  String get parish => _parish;

  set parish(String parish) {
    this._parish = parish;
  }


  String get place => _place;

  set place(String place) {
    this._place = place;
  }


  String get date => _date;

  set date(String date) {
    this._date = date;
  }


}
class Marriage7{
  String _catholicname;
String _catholicparents;
String _parish;
String _catholicgender;
String _noncatholicname;
String _noncatholicparents;
String _noncatholicresiding;
String _noncatholicgender;
String _noncatholictype;
String _noncatholicstatus;



  Marriage7(this._catholicname, this._catholicparents,this._parish,this._catholicgender, this._noncatholicname,  this._noncatholicparents, this._noncatholicresiding,this._noncatholicgender, this._noncatholictype, this._noncatholicstatus);



  String get catholicname => _catholicname;

  set catholicname(String catholicname) {
    this._catholicname = catholicname;
  }


String get noncatholicgender => _noncatholicgender;

  set noncatholicgender(String noncatholicgender) {
    this._noncatholicgender = noncatholicgender;
  }

  String get catholicgender => _catholicgender;

  set catholicgender(String catholicgender) {
    this._catholicgender = catholicgender;
  }
  String get catholicparents => _catholicparents;

  set catholicparents(String catholicparents) {
    this._catholicparents = catholicparents;
  }

 String get parish => _parish;

  set parish(String parish) {
    this._parish = parish;
  }


  String get noncatholicname => _noncatholicname;

  set noncatholicname(String noncatholicname) {
    this._noncatholicname = noncatholicname;
  }


  String get noncatholicparents => _noncatholicparents;

  set noncatholicparents(String noncatholicparents) {
    this._noncatholicparents = noncatholicparents;
  }


  String get noncatholicresiding => _noncatholicresiding;

  set noncatholicresiding(String noncatholicresiding) {
    this._noncatholicresiding = noncatholicresiding;
  }

String get noncatholictype => _noncatholictype;

  set noncatholictype(String noncatholictype) {
    this._noncatholictype = noncatholictype;
  }

  String get noncatholicstatus => _noncatholicstatus;

  set noncatholicstatus(String noncatholicstatus) {
    this._noncatholicstatus = noncatholicstatus;
  }







}