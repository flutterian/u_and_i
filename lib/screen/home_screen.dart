import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_DDay(), _CoupleImage()],
        ),
      ),
    );
  }
}

// 이름 첫글자가 언더스코어이면 다른 파일에서 접근 불가
class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('DDay Widget');
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Couple Image Widget');
  }
}
