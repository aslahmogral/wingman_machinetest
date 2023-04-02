import 'package:flutter/material.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/spashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider())
      ],
      child: MaterialApp(
        routes: {
          '/homescreen' : (context) =>HomeScreen()
        },
        debugShowCheckedModeBanner: false,
        title: 'Wingman',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff9170e2),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
