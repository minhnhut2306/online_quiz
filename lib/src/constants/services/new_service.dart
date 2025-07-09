import 'package:online_quiz/src/constants/models/newmodel.dart';
import 'package:online_quiz/src/constants/services/api_caller.dart';

class NewsService {
  Future<List<News>?> getNewsList() async {
    try {
      final url = 'api/news/list'; // Đường dẫn API lấy tin tức
      final response = await APICaller().get(url);

      print('API Response for News List: $response');

      // Kiểm tra nếu phản hồi có trường 'content' và dữ liệu trong 'content'
      if (response != null && response['content'] != null) {
        List<News> newsList = (response['content'] as List)
            .map((newsJson) => News.fromJson(newsJson))
            .toList();
        return newsList;
      } else {
        // Nếu không có trường 'content', in ra thông báo lỗi
        print('Error: Không có dữ liệu trong API response');
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
    }
    return null; // Trả về null nếu có lỗi
  }
}
