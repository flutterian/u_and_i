// 쿠퍼티노 (IOS) 위젯 사용하기 위해 필요
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_and_i/data/first_day_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _firstDay;

  @override
  void initState() {
    super.initState();
    _loadFirstDay();
  }

  Future<void> _loadFirstDay() async {
    final saved = await FirstDayStorage.load();
    setState(() {
      _firstDay = saved ?? DateTime.now();
    });
  }

  Future<void> _onFirstDayChanged(DateTime newDay) async {
    setState(() => _firstDay = DateTime(newDay.year, newDay.month, newDay.day));
    await FirstDayStorage.save(_firstDay!); // 절대 null 이 아니라는 표시로 뒤에 ! 붙여줌
  }

  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        // today를 날짜 단위(00:00:00)로 내림해 전달해야 날짜 피커의 최대 날짜가 명확히 오늘로 제한됨.
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        // firstDay가 today보다 크면 today로 바꿔줌
        final initial = _firstDay!.isAfter(today) ? today : _firstDay;
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              // initialDateTime은 maximumDate(오늘)보다 클 수 없으므로 보정. 크면 실제로 Exception에 잡혀버림.
              initialDateTime: initial,
              maximumDate: today,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                _onFirstDayChanged(date);
              },
            ),
          ),
        );
      },
      barrierDismissible: true, // 배경 눌렀을 때 다이얼로그 닫히도록함
    );
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
            _DDay(onHeartPressed: onHeartPressed, firstDay: _firstDay!),
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
