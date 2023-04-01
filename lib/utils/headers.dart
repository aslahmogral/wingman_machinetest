// import 'package:foody_restaurant/utils/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Headers {
  httpHeadersWithoutToken() {
    return {
      'Content-type': 'application/json',
    };
  }

  httpHeadersWithToken(String token)  {
    // final pref = await SharedPreferences.getInstance();
    // String? token = pref.getString(Constants.TOKEN);
    return {"Content-Type": "application/json", "Token": token};
  }
}
