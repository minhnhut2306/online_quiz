import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản Dịch vụ'),
        backgroundColor: Colors.blue[800],
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 8,
                color: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Điều khoản Dịch vụ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '1. Chấp nhận điều khoản\n'
                        'Bằng cách sử dụng dịch vụ "Thi trắc nghiệm online", bạn đồng ý tuân thủ các điều khoản và điều kiện được nêu trong tài liệu này. Nếu không đồng ý, vui lòng không sử dụng dịch vụ.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '2. Mục đích sử dụng\n'
                        'Dịch vụ được cung cấp nhằm hỗ trợ học tập và rèn luyện kỹ năng thi trắc nghiệm. Bạn cam kết sử dụng dịch vụ một cách hợp pháp và không sao chép, phân phối nội dung mà không có sự cho phép.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '3. Quyền sở hữu trí tuệ\n'
                        'Tất cả nội dung, bao gồm câu hỏi, bài thi và tài liệu, thuộc quyền sở hữu của chúng tôi. Bạn chỉ được sử dụng cho mục đích cá nhân và học tập.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '4. Giới hạn trách nhiệm\n'
                        'Chúng tôi không chịu trách nhiệm cho bất kỳ thiệt hại nào phát sinh từ việc sử dụng dịch vụ, bao gồm nhưng không giới hạn ở mất dữ liệu hoặc kết quả thi không chính xác.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '5. Thay đổi điều khoản\n'
                        'Chúng tôi có quyền thay đổi điều khoản này bất kỳ lúc nào. Các thay đổi sẽ có hiệu lực ngay khi được đăng tải trên trang web.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '6. Liên hệ\n'
                        'Nếu có thắc mắc, vui lòng liên hệ qua email: support@thitracnghiemonline.vn hoặc số điện thoại: 0901234567.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}