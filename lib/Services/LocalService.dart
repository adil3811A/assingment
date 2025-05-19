import 'package:shared_preferences/shared_preferences.dart';

const ACCESSTOKENKEY = 'accesstokenkey';

class LocalService{

  Future<void> storeAccessToken(String token)async{
    try{
      final pref =await SharedPreferences.getInstance();
      pref.setString(ACCESSTOKENKEY, token);
    }catch(e){
      print('not able to save access token');
    }
  }

}