class Profile{
   String _name;

 String _age;

  Profile(this._name, this._age);

 
  
  
  String get name => _name;

  set name(String name) {
    _name = name;
  }
   String get age => _age;

  set age(String age) {
    _age = age;
  }

}


