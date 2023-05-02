import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_starbhak_piket/pages/auth/authPage.dart';
import 'package:project_starbhak_piket/pages/jadwalPiket.dart';
import 'package:project_starbhak_piket/pages/keterlambatan.dart';
import 'package:project_starbhak_piket/pages/loadingPage.dart';
import 'package:project_starbhak_piket/pages/myControllerPage.dart';
import 'package:project_starbhak_piket/pages/rekapitulasi.dart';
import 'package:project_starbhak_piket/pages/tambahDataSiswa.dart';
import 'package:project_starbhak_piket/pages/bukuTamuPage.dart';
import 'package:project_starbhak_piket/pages/utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before changing the screen
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: JadwalPiketPage(),
    // );}}
    if (_isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.greenAccent),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              } else if (snapshot.hasData) {
                return const MyControllerPage();
              } else {
                return const AuthPage();
              }
            }),
      );
    }
  }
}
  
//   => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         scaffoldMessengerKey: Utils.messengerKey,
//         navigatorKey: navigatorKey,
//         home: StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(color: Colors.greenAccent),
//                 );
//               } else if (snapshot.hasError) {
//                 return const Center(
//                   child: Text("Something went wrong"),
//                 );
//               } else if (snapshot.hasData) {
//                 return const MyControllerPage();
//               } else {
//                 return const AuthPage();
//               }
//             }),
//       );

// }