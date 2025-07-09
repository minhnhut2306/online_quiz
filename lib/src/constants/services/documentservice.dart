
import 'package:online_quiz/src/constants/models/documentmodel.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class DocumentService {
  Future<List<Document>?> getDocumentsList() async {
    try {
      final url = 'api/document/list'; 
      final response = await APICaller().get(url);

      print('API Response for Documents List: $response');

      if (response != null && response['content'] != null) {
        List<Document> documentList = (response['content'] as List)
            .map((documentJson) => Document.fromJson(documentJson))
            .toList();
        return documentList;
      } else {
        
        print('Error: Không có dữ liệu trong API response');
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
    }
    return null; 
  }
}
