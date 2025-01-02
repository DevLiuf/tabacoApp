import 'package:tabacoapp/navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  // enableTestMode();

  runApp(const MyApp());
}

// void enableTestMode() {
//   List<String> testDeviceIds = ['60bf8dae5d48eb9f9fad45f16ba2ca5c'];
//   MobileAds.instance.initialize().then((value) {
//     MobileAds.instance.updateRequestConfiguration(
//       RequestConfiguration(
//         testDeviceIds: testDeviceIds,
//       ),
//     );
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigatorPage(),
    );
  }
}
