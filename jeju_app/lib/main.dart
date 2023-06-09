import 'package:flutter/material.dart';
import 'package:jeju_app/view/login.dart';
import 'package:jeju_app/view/search_id.dart';
import 'package:jeju_app/view/search_pw.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '42222ee726d15a11d6df8296460a7536',
    javaScriptAppKey: '007a8a13f09687a579b843bbac00c5bb',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColorDark: Color.fromARGB(207, 195, 172, 152),
          primaryColorLight: Color.fromARGB(197, 226, 218, 210),
          fontFamily: 'text'),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
