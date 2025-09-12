import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  void onHeartPressed() {
    setState(() {
      firstDay = firstDay.subtract(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(onHeartPressed: onHeartPressed, firstDay: firstDay),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

// 이름 첫글자가 언더스코어이면 다른 파일에서 접근 불가
class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const _DDay({required this.onHeartPressed, required this.firstDay});

  @override
  Widget build(BuildContext context) {
    // 테마 불러오기
    final textTheme = Theme.of(
      context,
    ).textTheme; // 위젯 트리 위 가장 가까운 Theme 값을 가져온다.
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text('U&I', style: textTheme.displayLarge),
        const SizedBox(height: 16.0),
        Text('우리 처음 만난 날', style: textTheme.bodyLarge),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ), // Icon의 경우 색상이 각각 다른 경우가 많아서 직접 지정
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expaneded 로 오버플로우 해결, 이미지가 남는 공간만큼만 차지하도록해준다. 위의 글자가 절반 이상을 차지하면서 생기는 문제.
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
