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
        toolbarHeight: 100,
        title: Text(
          "What's Your Location ?",
          style: GoogleFonts.notoSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        bottom: TabBar(
          indicatorWeight: 4.0,
          controller: _tabController,
          tabs: [
            Tab(
                height: 70,
                child: Text(
                  'Enter Location Yourself',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 233, 242, 255),
                    ),
                  ),
                )),
            Tab(
                height: 70,
                child: Text(
                  'Get Location through Geolocate',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 228, 238, 255),
                    ),
                  ),
                )),
          ],
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 140, bottom: 100, left: 40, right: 40),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.location_on,
                      size: 40,
                    ),
                    labelText: 'Enter Your Location',
                    hintText: 'Enter Your City/Town/Locality Name...',
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 22.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                )),
            Container(
              width: 240,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _loadingState = true;
                    _displayText = _textEditingController.text;
                  });
                  print('Text from TextField: $_displayText');
                  Provider.of<DataModel>(context, listen: false)
                      .setCityName(_displayText);
                  setState(() {
                    _loadingState = false;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: Row(
                  children: [
                    _loadingState
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
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
            ),
          ],
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 140, bottom: 100, left: 40, right: 40),
              child: Container(
                width: 190,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _loadingState = true;
                    });
                    int x = await Provider.of<DataModel>(context, listen: false)
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
                    "Set Location to ${value.cityName} ?",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  )
                : Container(),
            showError && !_loadingState
                ? Text("Error in getting location!")
                : Container(),
            showContinueButton && !_loadingState
                ? Container(
                    width: 240,
                    height: 50,
                    child: ElevatedButton(
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
        );
      },
    );
  }
}
