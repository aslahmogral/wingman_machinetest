// import 'package:foody_restaurant/utils/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Headers {
  httpHeadersWithoutToken() {
    return {
      'Content-type': 'application/json',
    };
  }

//   httpHeadersWithToken() async {
//     final pref = await SharedPreferences.getInstance();
//     String? token = pref.getString(Constants.TOKEN);
//     return {
//       'content-type': 'application/json',
//       'accept': 'application/json',
//       'authorization': 'Bearer $token'
//     };
//   }
}