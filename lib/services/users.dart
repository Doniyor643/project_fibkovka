
class Users{
  String name = '';
  String family = '';
  String email = '';
  String password = '';

  Users({required this.name,required this.family,required this.email,required this.password});

  Users.fromJson(Map<String,dynamic>json)
      : name = json['name'],
        family = json['family'],
        email = json['email'],
        password = json['password'];

  Map<String,dynamic>toJson()=>{
    'name':name,
    'family':family,
    'email':email,
    'password':password,
  };
}

class Work{
  String name = '';
  String summa = '';
  String text = '';
  String urlAddress = '';
  String size = '';
  String number = '';

  Work({
    required this.name,
    required this.summa,
    required this.text,
    required this.urlAddress,
    required this.size,
    required this.number
  });

  Work.fromJson(Map<String,dynamic>json)
      : name = json['name'],
        summa = json['summa'],
        text = json['text'],
        size = json['size'],
        number = json['number'],
        urlAddress = json['urlAddress'];


  Map<String,dynamic>toJson()=>{
    'name':name,
    'summa':summa,
    'text':text,
    'size':size,
    'number':number,
    'urlAddress':urlAddress,
  };
}