import 'dart:convert';

import 'package:tabacoapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  static Map<String, dynamic> res = {};
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _deleteData() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구매 내역 초기화'),
          content: const Text('모든 구매 내역을 초기화하시겠습니까?'),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('삭제',
                  style: TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                // Delete the data
                setState(() {
                  HomeScreen.dataStack.clear();
                  HomeScreen.prefs.setStringList('list', HomeScreen.dataStack);
                  HomeScreen.prefs.setString('data', '');
                  HomeScreen.productData = {};
                  HomeScreen.jsonString = '';
                  SettingScreen.res = {};

                  HomeScreen.jsonString = jsonEncode(HomeScreen.productData);
                  HomeScreen.prefs.setString('data', HomeScreen.jsonString);

                  try {
                    String? jsonData = HomeScreen.prefs.getString('data');
                    if (jsonData != null) {
                      HomeScreen.productData =
                          jsonDecode(jsonData); //스트링 리스트 어떻게 해야함?
                    }
                    List<String>? ddd = HomeScreen.prefs.getStringList('list');
                    if (ddd != null) {
                      HomeScreen.dataStack = ddd;
                    }
                  } catch (e) {}
                  HomeScreen.monthtotal = 0;
                  HomeScreen.weektotal = 0;
                  HomeScreen.monthtotal = 0;
                  HomeScreen.weektotal = 0;
                  HomeScreen.daytotal = 0;
                  HomeScreen.buyterm = 0;
                  HomeScreen.prefs.setInt('weektotal', HomeScreen.weektotal);
                  HomeScreen.prefs.setInt('monthtotal', HomeScreen.monthtotal);
                  HomeScreen.prefs.setInt('daytotal', HomeScreen.daytotal);
                  HomeScreen.prefs.setInt('buyterm', HomeScreen.buyterm);
                  // try {
                  //   int? weekTotal = HomeScreen.prefs.getInt('weektotal');
                  //   if (weekTotal != null) {
                  //     HomeScreen.weektotal = weekTotal;
                  //   }
                  //   int? monthTotal = HomeScreen.prefs.getInt('monthtotal');
                  //   if (monthTotal != null) {
                  //     HomeScreen.monthtotal = monthTotal;
                  //   }
                  //   int? dayTotal = HomeScreen.prefs.getInt('daytotal');
                  //   if (dayTotal != null) {
                  //     HomeScreen.daytotal = dayTotal;
                  //   }
                  // } catch (e) {}
                  HomeScreen.productData = SettingScreen.res;

                  print("초기화함!!");
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 140,
                      // width: 30,
                    ),
                    Text(
                      "담배연기에는 발암성 물질인 나프틸아민, 니켈, 벤젠,\n비닐 크롤라이드, 비소, 카드뮴이 들어있습니다",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: null,
                      // overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "금연상담전화 1544-9030",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 140,
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(
                  255,
                  250,
                  250,
                  250,
                ),
                foregroundDecoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Colors.black,
                  ),
                ),
                child: TextButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent,
                    ),
                  ),
                  child: const Text(
                    '구매 내역 초기화',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    _deleteData();
                  },
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '문의 csh001214@gmail.com',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
