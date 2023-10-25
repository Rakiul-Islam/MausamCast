import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class SetLocationPage extends StatelessWidget {
  const SetLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabs(),
    );
  }
}

class CustomTabs extends StatefulWidget {
  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 29, 66),
        toolbarHeight: 100,
        title: Text(
          "What's Your Location ?",
          style: GoogleFonts.notoSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 100, 160, 232),
            ),
          ),
        ),
        bottom: TabBar(
          indicatorWeight: 4.0,
          indicatorColor: Color.fromARGB(255, 100, 160, 232),
          controller: _tabController,
          tabs: [
            Tab(
                height: 70,
                child: Text(
                  !kIsWeb ? 'Enter' : 'Enter Location Yourself',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 100, 160, 232),
                    ),
                  ),
                )),
            Tab(
                height: 70,
                child: Text(
                  !kIsWeb ? 'Geolocate' : 'Get Location through Geolocate',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 100, 160, 232),
                    ),
                  ),
                )),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 77, 172),
      extendBodyBehindAppBar: (!kIsWeb) ? false : true,
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for Tab 1
          Center(
            child: CustomTab1(),
          ),

          // Content for Tab 2
          Center(
            child: CustomTab2(),
          ),
        ],
      ),
    );
  }
}

class CustomTab1 extends StatefulWidget {
  @override
  _CustomTab1State createState() => _CustomTab1State();
}

class _CustomTab1State extends State<CustomTab1> {
  TextEditingController _textEditingController = TextEditingController();
  String _displayText = '';
  bool _loadingState = false;
  var prefixIconColor = const Color.fromARGB(192, 255, 255, 255);

  void _setCity() async {
    setState(() {
      _loadingState = true;
      _displayText = _textEditingController.text;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
    setState(() {
      _loadingState = false;
    });
    print('Text from TextField: $_displayText');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void set_n_continue() {
    setState(() {
      _loadingState = true;
      _displayText = _textEditingController.text;
    });
    print('Text from TextField: $_displayText');
    Provider.of<DataModel>(context, listen: false).setCityName(_displayText);
    setState(() {
      _loadingState = false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: !kIsWeb ? 0 : 140, bottom: 100, left: 40, right: 40),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        prefixIconColor = hasFocus
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(180, 255, 255, 255);
                      });
                    },
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        icon: Icon(
                          color: prefixIconColor,
                          Icons.location_on,
                          size: 40,
                        ),
                        labelText: 'Enter Your Location',
                        hintText: 'Enter Your City/Town/Locality Name...',
                        labelStyle: const TextStyle(
                          color: Colors.white, // Label text color
                        ),
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(
                              105, 255, 255, 255), // Hint text color
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.8,
                              color: Color.fromARGB(136, 255, 255,
                                  255)), // Border color when not focused
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.5,
                              color: Color.fromARGB(229, 255, 255,
                                  255)), // Border color when focused
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 22.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                    ),
                  )),
              Container(
                width: 240,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(0, 0, 0, 0)),
                    shadowColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(0, 0, 0, 0)),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                          width: 3, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  onPressed: set_n_continue,
                  child: Row(
                    children: [
                      _loadingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Icon(
                              color: Colors.white,
                              Icons.sell_rounded,
                              size: 25,
                            ),
                      Text(
                        '    Set & Continue',
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomTab2 extends StatefulWidget {
  @override
  _CustomTab2State createState() => _CustomTab2State();
}

class _CustomTab2State extends State<CustomTab2> {
  bool _loadingState = false;
  bool showContinueButton = false;
  bool showGetCitySuccess = false;
  bool showError = false;
  String cityName = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: !kIsWeb ? 0 : 140, bottom: 100, left: 40, right: 40),
                child: Container(
                  width: 190,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(0, 0, 0, 0)),
                      shadowColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(0, 0, 0, 0)),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _loadingState = true;
                      });
                      int x =
                          await Provider.of<DataModel>(context, listen: false)
                              .setCityNameGeolocate();
                      print("x = $x");
                      if (x == 0) {
                        setState(() {
                          showGetCitySuccess = true;
                          showContinueButton = true;
                          showError = false;
                        });
                      } else {
                        setState(() {
                          showGetCitySuccess = false;
                          showContinueButton = false;
                          showError = true;
                        });
                      }
                      setState(() {
                        _loadingState = false;
                      });
                    },
                    child: Row(
                      children: [
                        _loadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                        Text(
                          '  Geolocate',
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              showGetCitySuccess && !_loadingState
                  ? Text(
                      "Set Location to ${value.cityName} ?\n",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 118, 252, 122),
                        ),
                      ),
                    )
                  : Container(),
              showError && !_loadingState
                  ? Text(
                      "Error in getting location!",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 143, 143),
                        ),
                      ),
                    )
                  : Container(),
              showContinueButton && !_loadingState
                  ? Container(
                      width: 240,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(0, 0, 0, 0)),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(0, 0, 0, 0)),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            _loadingState
                                ? const Icon(Icons.abc)
                                : const Icon(
                                    Icons.sell_rounded,
                                    size: 25,
                                  ),
                            Text(
                              '    Set & Continue',
                              style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
