import 'package:go_router/go_router.dart';
import 'package:online_quiz/src/screens/UserDetailScreen.dart';
import 'package:online_quiz/src/screens/about_us_page.dart';
import 'package:online_quiz/src/screens/dashboard.dart';
import 'package:online_quiz/src/screens/detailscreen.dart';
import 'package:online_quiz/src/screens/error_404.dart';
import 'package:online_quiz/src/screens/login_screen.dart';
import 'package:online_quiz/src/screens/quiz_layout.dart';
import 'package:online_quiz/src/screens/register_screen.dart';
import 'package:online_quiz/src/screens/terms_of_service_page.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        name: "Login",
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: "Register",
        path: '/register',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        name: "Dashboard",
        path: '/dashboard',
        builder: (context, state) => Dashboard(),
      ),
      GoRoute(
        name: 'Detail',
        path: '/detail',
        builder: (context, state) {
          final Map<String, dynamic>? data =
              state.extra as Map<String, dynamic>?;
          return DetailScreen(data: data, showDescription: true);
        },
      ),

      GoRoute(
        name: "UserDetail",
        path: '/user-detail',
        builder: (context, state) => UserDetailScreen(),
      ),
      // về chúng tôi
      GoRoute(
        name: "AboutUs",
        path: '/about-us',
        builder: (context, state) => const AboutUsPage(),
      ),
      // điều khoản dịch vụ
      GoRoute(
        name: "TermsOfService",
        path: '/terms-of-service',
        builder: (context, state) => const TermsOfServicePage(),
      ),
      // câu hỏi quiz_layout
      GoRoute(
        name: "QuizLayout",
        path: '/quiz-layout',
         builder: (context, state) => QuizLayout(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
