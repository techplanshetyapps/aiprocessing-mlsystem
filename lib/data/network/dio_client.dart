import 'package:dio/dio.dart';

/// فئة مخصصة لإدارة إعدادات وتكوين عميل الشبكة
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        // عنوان الخادم الأساسي الخاص بأجندة المهام
        baseUrl: 'https://jsonplaceholder.typicode.com',
        
        // مهلة محاولة الاتصال بالخادم بالثواني
        connectTimeout: const Duration(seconds: 10),
        
        // مهلة انتظار استقبال البيانات من الخادم بالثواني
        receiveTimeout: const Duration(seconds: 10),
        
        // الترويسات الافتراضية للطلبات لتحديد نوع البيانات
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.add(
        // إضافة مُعترض لمراقبة وتسجيل تفاصيل الطلبات، الاستجابات، والأخطاء في سجل التشغيل
        LogInterceptor(
          request: true,       // تسجيل معلومات الطلب المرسل
          requestBody: true,   // تسجيل محتوى بيانات الطلب
          responseBody: true,  // تسجيل محتوى بيانات الاستجابة المستقبلة
          error: true,         // تسجيل الأخطاء في حال حدوثها
        ),
      );
  }

  // خاصية للحصول على نسخة العميل الجاهزة للاستخدام في التطبيق
  Dio get instance => _dio;
}