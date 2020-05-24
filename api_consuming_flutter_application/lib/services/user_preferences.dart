import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences(){
    return _instance;
  }
  UserPreferences._ctor();
  SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //get y set name 
  get data{
    return _preferences.getString('data');
  }

  //set value
  set data(String value){
    _preferences.setString('data', value);
  }

  Future setApiKey (String apiKey){
    return _preferences.setString('apiKey', apiKey);
  }



}