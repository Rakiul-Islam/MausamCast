import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 0, 29, 66),
      appBar: AppBar(
        title: kIsWeb?Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              children: [
                const Icon(
                  Icons.wb_sunny_outlined,
                  size: 35,
                ),
                Text(" Forecast",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )),
              ],
            ),
          ):Container(),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Consumer<DataModel>(builder: (context, value, child) {
          if (value.weatherData.isNotEmpty) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            );
          } else {
            return Container();
          }
        }),
      ),
      drawer: const SideDrawer(),
      body: const Center(child: (kIsWeb) ? ForecastPageTiles() : AndroidForecastPageTiles()),
    );
  }
}

// ignore: must_be_immutable
class ForecastPageTiles extends StatefulWidget {
  const ForecastPageTiles({super.key});

  @override
  State<ForecastPageTiles> createState() => _ForecastPageTilesState();
}

class _ForecastPageTilesState extends State<ForecastPageTiles> {
  int hoveredButtonIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<ForecastData> dataList =
        Provider.of<DataModel>(context, listen: false).forecastData;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        bool isHovered = index == hoveredButtonIndex;
        ForecastData currForecastData = dataList[index];
        List dateTime = currForecastData.from.split(" ");
        List prevdateTime = (index > 0)? dataList[index-1].from.split(" ") : [];
        var avgTemp = (currForecastData.tempValue - 273.00).round();
        var maxTemp = currForecastData.tempMax - 273;
        var minTemp = currForecastData.tempMin - 273;
        var temp = (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
        var bgcolor = Color.fromARGB(
            255,
            ((temp - 10) * (255 / 35)).round(),
            ((45 - temp) * (255 / 35) * (0.5)).round(),
            ((45 - temp) * (255 / 35)).round());
        int imageName = int.parse(currForecastData.symbolVar
            .substring(0, currForecastData.symbolVar.length - 1));
        String imageNameMode = currForecastData.symbolVar.substring(
            currForecastData.symbolVar.length - 1,
            currForecastData.symbolVar.length);
        imageNameMode = (int.parse(dateTime[4].split(":")[0]) >= 6 &&
                int.parse(dateTime[4].split(":")[0]) <= 18)
            ? ("d")
            : ("n");
        if (imageName >= 4 && imageName < 9) {
          imageName = 4;
        } else if (imageName >= 11 && imageName < 13) {
          imageName = 11;
        } else if (imageName >= 13 && imageName < 50) {
          imageName = 13;
        }

          return Column(children: [
            (index == 0) || ((index > 0) && ( prevdateTime[1] != dateTime[1]) ) ?
            
            Padding(
              padding: const EdgeInsets.only(top:25, right: 450, bottom: 10),
              child: Text(
                        "${dateTime[0]} ${dateTime[1]} ${dateTime[2]} ${dateTime[3]}",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(117, 255, 255, 255)),
                        ),
                      ),
            ) : Container(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
              child: Center(
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: (isHovered)
                        ? Color.fromARGB((bgcolor.alpha * 0.5).toInt(),
                            bgcolor.red, bgcolor.green, bgcolor.blue)
                        : bgcolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(milliseconds: 300),
                  width: (index == hoveredButtonIndex) ? 760 : 720,
                  height: (hoveredButtonIndex != -1)
                      ? (index == hoveredButtonIndex ? 110 : 84)
                      : (88),
                  child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          hoveredButtonIndex = index;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          hoveredButtonIndex = -1;
                        });
                      },
                      child: Stack(children: [
                        Positioned(
                          left: 40,
                          top: (isHovered) ? 12 : 12,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${dateTime[4].split(":")[0]} : ${dateTime[4].split(":")[1]}",
                              style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                                    fontSize: (isHovered) ? 40 : 44,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                        (isHovered)
                            ? (Positioned(
                                left: 40,
                                top: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${dateTime[0]} ${dateTime[1]} ${dateTime[2]} ${dateTime[3]}",
                                    style: GoogleFonts.notoSans(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                ),
                              ))
                            : (Container()),
                        Positioned(
                            left: isHovered ? 240 : 300,
                            top: isHovered ? 25 : 20,
                            child: Text(
                              isHovered
                                  ? "${minTemp.toStringAsFixed(2)} - ${maxTemp.toStringAsFixed(2)} °C"
                                  : "$avgTemp °C",
                              style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            )),
                        Positioned(
                          right: 40,
                          bottom: 10,
                          child: Image.asset(
                            imageName <= 9
                                ? 'lib/images/icons/0$imageName$imageNameMode.png'
                                : 'lib/images/icons/$imageName$imageNameMode.png',
                            width: isHovered ? 60 : 67,
                            height: isHovered ? 60 : 67,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                'lib/images/icons/notFound.png',
                                width: isHovered ? 60 : 67,
                                height: isHovered ? 60 : 67,
                              );
                            },
                          ),
                        ),
                        isHovered
                            ? (Positioned(
                                right: 40,
                                top: 10,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Humidity: ${currForecastData.humidityValue}${currForecastData.humidityUnit}",
                                    style: GoogleFonts.notoSans(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                ),
                              ))
                            : (Container()),
                        Positioned(
                          right: 120,
                          bottom: 13,
                          child: Text(
                            isHovered
                                ? capitalizeWords(currForecastData.symbolName)
                                    .replaceAll(" ", "\n")
                                : capitalizeWords(currForecastData.symbolName),
                            style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                  fontSize: isHovered ? 15 : 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ])),
                ),
              ),
            )
          ]);}
    );
  }
}


// ignore: must_be_immutable
class AndroidForecastPageTiles extends StatefulWidget {
  const AndroidForecastPageTiles({super.key});

  @override
  State<AndroidForecastPageTiles> createState() => _AndroidForecastPageTilesState();
}

class _AndroidForecastPageTilesState extends State<AndroidForecastPageTiles> {
  int? tappedButtonIndex;
  @override
  Widget build(BuildContext context) {
    List<ForecastData> dataList =
        Provider.of<DataModel>(context, listen: false).forecastData;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        final isTapped = index == tappedButtonIndex;
        ForecastData currForecastData = dataList[index];
        List dateTime = currForecastData.from.split(" ");
        List prevdateTime = (index > 0)? dataList[index-1].from.split(" ") : [];
        var avgTemp = (currForecastData.tempValue - 273.00).round();
        var maxTemp = currForecastData.tempMax - 273;
        var minTemp = currForecastData.tempMin - 273;
        var temp = (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
        var bgcolor = Color.fromARGB(
            255,
            ((temp - 10) * (255 / 35)).round(),
            ((45 - temp) * (255 / 35) * (0.5)).round(),
            ((45 - temp) * (255 / 35)).round());
        int imageName = int.parse(currForecastData.symbolVar
            .substring(0, currForecastData.symbolVar.length - 1));
        String imageNameMode = currForecastData.symbolVar.substring(
            currForecastData.symbolVar.length - 1,
            currForecastData.symbolVar.length);
        imageNameMode = (int.parse(dateTime[4].split(":")[0]) >= 6 &&
                int.parse(dateTime[4].split(":")[0]) <= 18)
            ? ("d")
            : ("n");
        if (imageName >= 4 && imageName < 9) {
          imageName = 4;
        } else if (imageName >= 11 && imageName < 13) {
          imageName = 11;
        } else if (imageName >= 13 && imageName < 50) {
          imageName = 13;
        }

          return Column(children: [
            (index == 0) || ((index > 0) && ( prevdateTime[1] != dateTime[1]) ) ?
            
            Padding(
              padding: const EdgeInsets.only(top:25, right: 20, bottom: 10,left: 20),
              child: Text(
                        "${dateTime[0]} ${dateTime[1]} ${dateTime[2]} ${dateTime[3]}",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(117, 255, 255, 255)),
                        ),
                      ),
            ) : Container(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
              child: InkWell(
                onTap: () {
                  setState(() {
                    tappedButtonIndex = isTapped ? null : index;
                  });
                },
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: isTapped
                        ? Color.fromARGB((bgcolor.alpha * 0.5).toInt(),
                            bgcolor.red, bgcolor.green, bgcolor.blue)
                        : bgcolor,
                    borderRadius: BorderRadius.circular(6.5),
                  ),
                  duration: const Duration(milliseconds: 195),
                  width: isTapped ? 494 : 455,
                  height: isTapped ? 71.5 : 54.6,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: (isTapped) ? 7.8 : 7.8,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${dateTime[4].split(":")[0]}:${dateTime[4].split(":")[1]}",
                            style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                fontSize: (isTapped) ? 26 : 28.6,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (isTapped)
                          ? Positioned(
                              left: 20,
                              top: 45,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${dateTime[0]} ${dateTime[1]} ${dateTime[2]}",
                                  style: GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 11.7,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        left: isTapped ? 120 : 130,
                        top: isTapped ? 16.2 : 13.0,
                        child: Text(
                          isTapped
                              ? "${minTemp.round()}-${maxTemp.round()} °C"
                              : "$avgTemp °C",
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 24.7,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 5,
                        child: Image.asset(
                          imageName <= 9
                              ? 'lib/images/icons/0$imageName$imageNameMode.png'
                              : 'lib/images/icons/$imageName$imageNameMode.png',
                          width: isTapped ? 39.0 : 43,
                          height: isTapped ? 39.0 : 43,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'lib/images/icons/notFound.png',
                              width: isTapped ? 39.0 : 43,
                              height: isTapped ? 39.0 : 43,
                            );
                          },
                        ),
                      ),
                      isTapped
                          ? Positioned(
                              right: 20,
                              top: 5.2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Humidity: ${currForecastData.humidityValue}${currForecastData.humidityUnit}",
                                  style: GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        right: 82,
                        bottom: 10,
                        child: Text(
                          capitalizeWords(currForecastData.symbolName)
                              .replaceAll(" ", "\n"),
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: isTapped ? 9.75 : 11.7,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);}
    );
  }
}
