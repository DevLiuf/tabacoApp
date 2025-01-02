import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static List<String> dataStack = []; //dataStack 값 공유 가능
  static List<String> savedData = [];
  static Map<String, dynamic> productData = {};
  static String jsonString = '';

  static late SharedPreferences prefs;
  static int weektotal = 0;
  static int monthtotal = 0;
  static int daytotal = 0;
  static int buyterm = 0;

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void calWeekTotal() {
  const int duration = 7; // 일주일(7일)

  final DateTime now = DateTime.now();
  final DateTime startDate = now.subtract(const Duration(days: duration));
  final DateTime endDate = now;

  int wtotal = 0;
  if (HomeScreen.productData.containsKey('data')) {
    final Map<String, dynamic> dateData = HomeScreen.productData['data'];
    for (final String date in dateData.keys) {
      final DateTime currentDate = DateFormat('yyyy년 MM월 dd일').parse(date);
      if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
        final Map<String, dynamic> timeData = dateData[date];
        for (final String time in timeData.keys) {
          final int price = int.parse(timeData[time]['price']);
          wtotal += price;
        }
      }
    }
  }

  HomeScreen.weektotal = wtotal;
  HomeScreen.prefs.setInt('weektotal', HomeScreen.weektotal);

  print("weekTotal = ${HomeScreen.weektotal}");
}

void calMonthTotal() {
  const int duration = 30; // 30일

  final DateTime now = DateTime.now();
  final DateTime startDate = now.subtract(const Duration(days: duration));
  final DateTime endDate = now;

  int mtotal = 0;

  if (HomeScreen.productData.containsKey('data')) {
    final Map<String, dynamic> dateData = HomeScreen.productData['data'];
    for (final String date in dateData.keys) {
      final DateTime currentDate = DateFormat('yyyy년 MM월 dd일').parse(date);
      if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
        final Map<String, dynamic> timeData = dateData[date];
        for (final String time in timeData.keys) {
          final int price = int.parse(timeData[time]['price']);
          mtotal += price;
        }
      }
    }
  }
  print(mtotal);

  HomeScreen.monthtotal = mtotal;
  HomeScreen.prefs.setInt('monthtotal', HomeScreen.monthtotal);

  print("monthTotalddd = ${HomeScreen.monthtotal}");
}

void calculateTotalPrice() {
  int dtotal = 0;

  if (HomeScreen.productData.containsKey('data')) {
    final Map<String, dynamic> dateData = HomeScreen.productData['data'];
    for (final Map<String, dynamic> timeData in dateData.values) {
      for (final Map<String, dynamic> purchaseData in timeData.values) {
        final int price = int.tryParse(purchaseData['price'] ?? '') ?? 0;
        dtotal += price;
      }
    }
  }
  HomeScreen.daytotal = dtotal;

  HomeScreen.prefs.setInt('daytotal', HomeScreen.daytotal);
  print('전체 price 합: ${HomeScreen.daytotal}"');
}

void calculateDaysSinceLastPurchase() {
  final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');

  if (HomeScreen.productData['data'] != null) {
    final List<String> dates = HomeScreen.productData['data'].keys.toList();
    dates.sort((a, b) => formatter.parse(b).compareTo(formatter.parse(a)));

    if (dates.length > 1) {
      final DateTime lastPurchaseDate = formatter.parse(dates[1]);
      final DateTime currentDate = DateTime.now();
      final Duration difference = currentDate.difference(lastPurchaseDate);
      final int daysSinceLastPurchase = difference.inDays;
      HomeScreen.buyterm = daysSinceLastPurchase;

      print('이전 구매로부터 경과한 일수: ${HomeScreen.buyterm}');
    } else {
      print('이전 구매 데이터가 없습니다.');
    }
  } else {
    print('데이터가 없습니다.');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String _scanBarcode = '';
  Map<String, dynamic> _semiData = {};
  // int weekTotal = 0;
  // int monthTotal = 0;
  // int dayTotal = 0;
  // int buyTerm = 0;

  final List<String> textList = [
    "담배꽁초는 쓰레기통에",
    "암보험으로 낭낭하게 챙기세요",
    "가만히 있어도 성공하는 \n가장 쉬운 도전, 금연",
    "난 네가 용인 줄 알았어. \n계속해서 연기를 내뿜으니까",
    "넌 항상 겨울이야 \n숨을 내뿜으면 나오는 연기가 입김 같아",
    "이해해, 담배는 네 인생의 \n풍요로운 조미료인 것 같아",
    "네가 흡연하지 않는 날은 \n공기청정기가 심심해할 거 같아",
    "너랑 있으면 항상 날씨가 흐림이야",
    "너 마술사야? 입에서 연기가 나오네?",
    "공기 대신 발암물질만 있는 행성에서\n 너는 살아남을 거 같아",
    "고마워 아까운 산소 대신 \n니코틴을 흡입해 줘서",
    "발암물질과 검은 머리 파뿌리 될 때까지 \n함께 하겠습니까?",
    "줄줄 새는 주머니, 계속 피겠습니까?",
  ];

  late List<String> ranList = [];
  late Stream<String> textStream;
  Random rand = Random();

  String formattedDate = '';
  String formattedTime = '';
  @override
  void initState() {
    super.initState();

    textStream = Stream<String>.periodic(const Duration(seconds: 3), (index) {
      // 1초마다 textList에서 랜덤하게 요소를 선택해서 반환
      return textList[rand.nextInt(textList.length)];
    });

    print("productData start ${HomeScreen.productData}");
    print("jsonString ${HomeScreen.jsonString}");

    print("monthTotalinit = ${HomeScreen.monthtotal}");

    // initializeSharedPreferences();
    loadSavedData();
    // print("aa$textList");
  }

  // Future<void> initializeSharedPreferences() async {
  //   HomeScreen.prefs = await SharedPreferences.getInstance();
  //   // HomeScreen.savedData = HomeScreen.prefss.getStringList('data') ?? [];

  //   // HomeScreen.dataStack = HomeScreen.savedData;
  // }

  void loadSavedData() async {
    print("monthTotalLoad = ${HomeScreen.monthtotal}");

    HomeScreen.prefs = await SharedPreferences.getInstance();
    try {
      String? jsonData = HomeScreen.prefs.getString('data');
      if (jsonData != null) {
        HomeScreen.productData = jsonDecode(jsonData); //스트링 리스트 어떻게 해야함?
      }
      List<String>? ddd = HomeScreen.prefs.getStringList('list');
      if (ddd != null) {
        HomeScreen.dataStack = ddd;
      }
    } catch (e) {}
    print("monthTotalLoad ssss = ${HomeScreen.monthtotal}");

    try {
      int? weekTotal = HomeScreen.prefs.getInt('weektotal');
      if (weekTotal != null) {
        HomeScreen.weektotal = weekTotal;
      }
      int? monthTotal = HomeScreen.prefs.getInt('monthtotal');
      if (monthTotal != null) {
        HomeScreen.monthtotal = monthTotal;
      }
      int? dayTotal = HomeScreen.prefs.getInt('daytotal');
      if (dayTotal != null) {
        HomeScreen.daytotal = dayTotal;
      }
    } catch (e) {}

    calWeekTotal();
    calMonthTotal();
    calculateTotalPrice();
    calculateDaysSinceLastPurchase();
    print("monthTotalLoadout = ${HomeScreen.monthtotal}");
  }

  void saveData() async {
    print("productData 1111 ${HomeScreen.productData}");

    print("productData 3333 ${HomeScreen.productData}");

    formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
    formattedTime = DateFormat('HH시mm분').format(DateTime.now());
    // String formattedE = DateFormat('EEEE', 'ko').format(DateTime.now());

    // dynamic newData =
    //     "$formattedDate $formattedTime\n${productData['name']}\n${productData['price']}원";

    // HomeScreen.prefss.setStringList('data', HomeScreen.dataStack);
    // print(newData);
    Map<String, dynamic> newData = {
      'name': '${_semiData['name']}',
      'price': '${_semiData['price']}'
    };

    if (HomeScreen.productData.containsKey('data')) {
      Map<String, dynamic> dateData = HomeScreen.productData['data'];
      if (dateData.containsKey(formattedDate)) {
        Map<String, dynamic> timeData = dateData[formattedDate];
        timeData[formattedTime] = newData;
      } else {
        dateData[formattedDate] = {formattedTime: newData};
      }
    } else {
      HomeScreen.productData['data'] = {
        formattedDate: {formattedTime: newData}
      };
    }

    HomeScreen.jsonString = jsonEncode(HomeScreen.productData);
    HomeScreen.prefs.setString('data', HomeScreen.jsonString);
    try {
      HomeScreen.productData['data'].forEach((date, timeData) {
        timeData.forEach((time, productData) {
          String name = productData['name'];
          String price = productData['price'];
          String data = '$date $time \n$name \n$price' "원";

          // 중복된 데이터인지 확인
          bool isDuplicate = HomeScreen.dataStack.any((item) => item == data);
          if (!isDuplicate) {
            HomeScreen.dataStack.insert(0, data);
          }
        });
      });
      HomeScreen.prefs.setStringList('list', HomeScreen.dataStack);
    } catch (e) {
      // 예외 처리
    }

    print("productData 1111 ${HomeScreen.productData}");
    print("jsonString ${HomeScreen.jsonString}");
    // HomeScreen.dataStack.insert(0,
    //     "$formattedDate $formattedTime $formattedE\n${_semiData['name']}\n${_semiData['price']}원");

    print("dataStack ${HomeScreen.dataStack}");

    loadSavedData();
    print("productData 2222 ${HomeScreen.productData}");

    // _calWeekTotal();
    // _calMonthTotal();
    // _calculateTotalPrice();
    // _calculateDaysSinceLastPurchase();
    // mintotal();
    // const String targetDate = formattedDate;
    // const String startTime = "13시21분";
  }

  // String getToday() {
  //   DateTime now = DateTime.now();
  //   DateFormat formatter = DateFormat('yyyy년 MM월 dd일 E요일 h시 m분', 'ko');
  //   return formatter.format(now);
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print('바코드 인식 됨');
    });

    final String jsonFileData = await _loadJsonFileData();
    final dynamic jsonData = json.decode(jsonFileData);

    final List<dynamic> productList = jsonData['products'];
    // print(productList);

    for (final dynamic product in productList) {
      if (product['barcode'] == _scanBarcode) {
        if (product.isNotEmpty) {
          _semiData = product;
          // print("_semiData $_semiData");
          print('Product Name: ${_semiData['name']}');
          print('Product Price: ${_semiData['price']}');
          print('product Barcode: ${_semiData['barcode']}');
          // print(barcodeScanRes);
          saveData();
        } else {
          print('No product found with this barcode.');
        }
        break;
      }
    }
  }

  Future<String> _loadJsonFileData() async {
    const String jsonFilePath = 'assets/barcode_data.json';

    return await rootBundle.loadString(jsonFilePath);
  }

  @override
  Widget build(BuildContext context) {
    // barcodeMap();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 1,
                  ),
                  child: Container(
                    foregroundDecoration:
                        BoxDecoration(border: Border.all(width: 7)),
                    height: 170,
                    width: double.infinity, // 너비를 최대로
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<String>(
                          stream: textStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              return Expanded(
                                child: Text(
                                  snapshot.data ?? 'No Data',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      width: 300,
                      height: 300,
                      // color: const Color.fromARGB(255, 228, 228, 228),
                      foregroundDecoration:
                          BoxDecoration(border: Border.all(width: 7)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text(
                          //   '바코드를 촬영하세요',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              scanBarcodeNormal();
                            },
                            icon: const Icon(CupertinoIcons.barcode),
                            iconSize: 200,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "새로운 담배를 개봉할 때마다\n위 바코드를 터치하고 \n담배 측면의 바코드를 촬영해 주세요",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
