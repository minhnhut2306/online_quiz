import 'package:online_quiz/src/constants/models/exammodel.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class ExamService {

  Future<Exam?> getByexamId(int? idExam) async {
    if (idExam == null) {
      print('Exam ID is null');
      return null; 
    }

    try {
      final response = await APICaller().get('api/exam/$idExam'); 

      print('API Response for Exam ID $idExam: $response'); 

      if (response != null && response['content'] != null) {
        return Exam.fromJson(response['content']); 
      } else {
        String message = response?['message'] ?? 'No message provided';
        print('Error: $message');
      }
    } catch (e) {
      print('Error calling API: $e');  
    }
    return null; 
  }
}
