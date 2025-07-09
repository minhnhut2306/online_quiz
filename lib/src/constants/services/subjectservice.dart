import 'dart:convert';
import 'package:online_quiz/src/constants/models/subjectmodel.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class SubjectService {
  Future<List<Subject>> getAllSubjects() async {
    try {
      final response = await APICaller().get('api/subject/getall');


      if (response != null) {
   
        print('API response: $response');


        if (response is List) {
    
          print('Subjects list: $response');
          
       
          return response.map((e) => Subject.fromMap(e)).toList();
        } else {
          print('Dữ liệu không phải là List');
        }
      } else {
        print('Không nhận được dữ liệu từ API');
      }
    } catch (e) {
   
      print('Error when calling API: $e');
    }

  
    return [];
  }
}
