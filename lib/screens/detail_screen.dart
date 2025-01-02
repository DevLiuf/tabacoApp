import 'dart:convert';

import 'package:tabacoapp/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});
  static Map<String, dynamic> del = {};

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void rem(int index) {
    try {
      if (index >= 0 && index < HomeScreen.dataStack.length) {
        String dataStackItem = HomeScreen.dataStack[index];
        List<String> lines = dataStackItem.split('\n');
        if (true) {
          String dateTimeLine = lines[0];
          List<String> parts = dateTimeLine.split(' ');
          if (true) {
            String date = '${parts[0]} ${parts[1]} ${parts[2]}';
            String time = parts[3];
            print('날짜: $date');
            print('시간: $time');
            HomeScreen.productData['data'].forEach((dateKey, timeData) {
              if (timeData.containsKey(time)) {
                print("데이터 지움!!");
                timeData.remove(time);
              }
            });
            HomeScreen.productData['data'].forEach((dateKey, timeData) {
              if (timeData.isEmpty) {
                HomeScreen.productData['data'].remove(dateKey);
              }
            });
          }
        }
      }
    } catch (e) {}
    DetailScreen.del = HomeScreen.productData;
    HomeScreen.dataStack.remove(HomeScreen.dataStack[index]);
  }

  void _deleteData(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구매 내역 삭제'),
          content: const Text('이 항목을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                '삭제',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  print("ddddd${HomeScreen.dataStack[index]}");
                  // // 추가된 부분
                  rem(index);

                  HomeScreen.jsonString = jsonEncode(HomeScreen.productData);
                  HomeScreen.prefs.setString('data', HomeScreen.jsonString);
                  HomeScreen.prefs.setStringList('list', HomeScreen.dataStack);
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

                  calWeekTotal();
                  calMonthTotal();
                  calculateTotalPrice();
                  calculateDaysSinceLastPurchase();
                  print("dellll ${DetailScreen.del}");
                  HomeScreen.productData = DetailScreen.del;

                  print(HomeScreen.dataStack);
                  print(HomeScreen.productData);
                });
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
      appBar: AppBar(
        title: const Text(
          '전체 내역',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                // reverse: true,
                shrinkWrap: true,
                itemCount: HomeScreen.dataStack.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black,
                  height: 5,
                ),
                itemBuilder: (context, index) => ListTile(
                  title: Text(HomeScreen.dataStack[index]),
                  trailing: IconButton(
                    onPressed: () {
                      print(HomeScreen.productData);

                      _deleteData(index);
                    },
                    icon: const Icon(
                      CupertinoIcons.xmark,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
