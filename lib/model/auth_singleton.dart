class Singleton {
  static final Singleton _singleton = Singleton._internal();

  static String _token = '';

  factory Singleton() {
    return _singleton;
  }

  void SetToken(String token){
    _token = token;
  }

  String GetToken(){
    return _token;
  }

  Singleton._internal();
}