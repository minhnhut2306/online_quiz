import 'package:online_quiz/src/constants/models/resultmodel.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class ResultService {
  Future<List<Result>> getTop10() async {
    try {
      final response = await APICaller().get('api/results/top-ten'); 

      if (response != null && response['content'] != null) {
        List list = response['content']; 
        return list.map((e) => Result.fromJson(e)).toList();
      } else {
        String message = response?['message'] ?? 'Không có dữ liệu hoặc mã lỗi không hợp lệ';
        print('Lý do: $message');
      }
    } catch (e) {
     
    }
    return [];  
  }
}
