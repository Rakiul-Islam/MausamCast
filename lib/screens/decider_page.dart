import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/home_page.dart';
import 'package:my_weather_app/screens/set_location_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({super.key});

  Future<String> myFuture(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String cityName = prefs.getString('LocalCityName') ?? "";
    // ignore: use_build_context_synchronously
    await Provider.of<DataModel>(context, listen: false).setCityName(cityName);
    return cityName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: myFuture(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 29, 66),
            extendBodyBehindAppBar: true,
            body: Center(
                child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.white,
                  ),
                  Text(
                    "  Checking Cache",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final cityName = snapshot.data;
          print("got cityname $cityName");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MausamCast',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:
                (cityName == "") ? const SetLocationPage() : const HomeScreen(),
          );
        }
      },
    );
  }
}
