import 'package:tabacoapp/screens/detail_screen.dart';
import 'package:tabacoapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // InterstitialAd? _interstitialAd;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadInterstitialAd();
  //   _showInterstitialAd();
  // }

  // void _loadInterstitialAd() {
  //   String adUnitId = AdHelper.interstitialAdUnitId;
  //   InterstitialAd.load(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _interstitialAd = ad;
  //         });
  //       },
  //       onAdFailedToLoad: (error) {
  //         print('InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // void _showInterstitialAd() {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.show();
  //   } else {
  //     print('Interstitial ad not loaded yet.');
  //   }
  // }

  // @override
  // void dispose() {
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }

  // AdManagerInterstitialAd? _interstitialAd;

  // void loadAd() {
  //   AdManagerInterstitialAd.load(
  //       adUnitId: Platform.isAndroid
  //           ? 'ca-app-pub-7455418657343277/3837692402'
  //           : 'ca-app-pub-7455418657343277/5262454713',
  //       request: const AdManagerAdRequest(),
  //       adLoadCallback: AdManagerInterstitialAdLoadCallback(
  //         onAdLoaded: (ad) {
  //           debugPrint('$ad loaded.');
  //           _interstitialAd = ad;
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           debugPrint('AdManagerInterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  var f = NumberFormat('###,###,###,###,###,###,###,###');

  String dayy =
      ((HomeScreen.daytotal / 9620 / 8).floorToDouble()).toStringAsFixed(0);
  String timee = ((HomeScreen.daytotal / 9620.floorToDouble() -
          (HomeScreen.daytotal / 9620 / 8.floorToDouble())))
      .toStringAsFixed(0);

  // HomeScreen.prefs.setInt('weektotal', HomeScreen.weektotal);
  // HomeScreen.prefs.setInt('monthtotal', HomeScreen.monthtotal);
  // HomeScreen.prefs.setInt('daytotal', HomeScreen.daytotal);
  // HomeScreen.prefs.setInt('buyterm', HomeScreen.buyterm);

  void All_State() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DetailScreen(),
          fullscreenDialog: true,
        ));

    print("dd");
  }

  @override
  Widget build(BuildContext context) {
    print(HomeScreen.daytotal);
    print(HomeScreen.weektotal);
    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 300,
                  height: 80,
                  margin: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "최근 일주일 지출",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${f.format(HomeScreen.weektotal)}원",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 15,
              //   width: 250,
              //   child: Divider(
              //     color: Colors.black54,
              //     thickness: 1.5,
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 300,
                  height: 80,
                  margin: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "최근 한 달 지출",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${f.format(HomeScreen.monthtotal)}원",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 300,
                  height: 80,
                  margin: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "전체 지출",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${f.format(HomeScreen.daytotal)}원",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 300,
                  height: 80,
                  margin: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "담배 재구매 기간",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${HomeScreen.buyterm}일",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${((HomeScreen.daytotal / 10000).floorToDouble().toStringAsFixed(0))} 국밥",
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${((HomeScreen.daytotal / 20000).floorToDouble().toStringAsFixed(0))} 치킨",
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Text(
                        "국밥: 10,000원\n치킨: BBQ 황금올리브 20,000원",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "전체 지출을 최저시급으로 계산하면?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$dayy일 $timee시간",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "8시간 = 1일",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 250, 250, 250),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Colors.black,
                        style: BorderStyle.solid),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      ),
                    ),
                    child: const Text(
                      '전체 내역',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      All_State();
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
