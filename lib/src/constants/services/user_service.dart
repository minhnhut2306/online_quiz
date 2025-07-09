import 'package:online_quiz/src/constants/models/user.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';


class UserService {
  Future<User?> getUserById(String userId) async {
    try {
      final response = await APICaller().get('api/user/$userId');  
      print('API Response uswer: $response');  

      if (response != null && response['code'] == 200 && response['data'] != null) {
        return User.fromJson(response['data']);
      } else {
        print('Error: ${response['message']}');
      }
    } catch (e) {
      print('Error calling API: $e');
    }
    return null;
  }
}
