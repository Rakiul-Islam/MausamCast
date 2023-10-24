import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/set_location_page.dart';
import 'package:provider/provider.dart';

String capitalizeWords(String input) {
  List<String> words = input.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }
  return words.join(' ');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<int> myFuture;

  @override
  void initState() {
    if (!kIsWeb) {
      myFuture =
          Provider.of<DataModel>(context, listen: false).fetchBothDataRemote();
    } else {
      myFuture = Provider.of<DataModel>(context, listen: false).fetchBothData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 29, 66),
        extendBodyBehindAppBar: kIsWeb,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return SetLocationPage();
              }));
            },
          ),
        ),
        body: value.dataFetchedOnce
            ? const Padding(
                padding: EdgeInsets.only(top: 20), child: HomePageLayout())
            : FutureBuilder<int>(
                future: myFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      print("from fetchData : ${snapshot.data}");
                      if (snapshot.data == 0) {
                        return const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: HomePageLayout());
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 980,
                              height: 60,
                              child: Row(
                                children: [
                                  const Icon(
                                    color: Color.fromARGB(255, 250, 137, 129),
                                    Icons.error,
                                    size: 50,
                                  ),
                                  Text(
                                    "  Problem in fetching data from server...Did you set the location correctly?",
                                    style: GoogleFonts.notoSans(
                                      textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 196, 192, 192),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                    default:
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 250,
                          height: 60,
                          child: Row(
                            children: [
                              const CircularProgressIndicator(
                                strokeWidth: 5,
                                color: Colors.white,
                              ),
                              Text(
                                "  Loading...",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                },
              ),
      );
    });
  }
}

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? ListView(
            children: [
              const Align(
                alignment: Alignment.center,
                child: AndroidWeatherDataTile(),
              ),
              Container(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      color: Color.fromARGB(117, 255, 255, 255),
                      Icons.history,
                      size: 30,
                    ),
                    Text(
                      " History",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(117, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: AndroidStatGraph(),
              ),
              Container(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      color: Color.fromARGB(117, 255, 255, 255),
                      Icons.wb_sunny,
                      size: 30,
                    ),
                    Text(
                      " Forecast",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(117, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: AndroidForecastTilesView(),
              ),
              Container(
                height: 30,
              ),
            ],
          )
        : SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(
                              top: 40, bottom: 5, right: 40, left: 55),
                          child: WeatherDataTile()),
                      const Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 10, right: 40, left: 55),
                          child: StatGraph()),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Container(
                          width: 510,
                          child: Row(
                            children: [
                              const Icon(
                                color: Color.fromARGB(117, 255, 255, 255),
                                Icons.history,
                                size: 30,
                              ),
                              Text(
                                " History",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(117, 255, 255, 255)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, bottom: 10),
                        child: Container(
                          width: 670,
                          child: Row(
                            children: [
                              const Icon(
                                color: Color.fromARGB(117, 255, 255, 255),
                                Icons.wb_sunny,
                                size: 30,
                              ),
                              Text(
                                " Forecast",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(117, 255, 255, 255)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, right: 40, left: 30),
                          child: ForecastTilesView()),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class WeatherDataTile extends StatefulWidget {
  const WeatherDataTile({super.key});

  @override
  State<WeatherDataTile> createState() => _WeatherDataTileState();
}

class _WeatherDataTileState extends State<WeatherDataTile> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      WeatherData currWeatherData =
          value.weatherData[value.weatherData.length - 1];
      List dateTime = currWeatherData.dateTime.split(" ");
      var avgTemp = (currWeatherData.temperatureValue - 273.00).round();
      var maxTemp = currWeatherData.temperatureMax - 273;
      var minTemp = currWeatherData.temperatureMin - 273;
      var temp = (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
      var bgcolor = Color.fromARGB(
          255,
          ((temp - 10) * (255 / 35)).round(),
          ((45 - temp) * (255 / 35) * (0.5)).round(),
          ((45 - temp) * (255 / 35)).round());
      int imageName = int.parse(currWeatherData.weatherIcon
          .substring(0, currWeatherData.weatherIcon.length - 1));
      String imageNameMode = currWeatherData.weatherIcon.substring(
          currWeatherData.weatherIcon.length - 1,
          currWeatherData.weatherIcon.length);
      if (imageName >= 4 && imageName < 9) {
        imageName = 4;
      } else if (imageName >= 11 && imageName < 13) {
        imageName = 11;
      } else if (imageName >= 13 && imageName < 50) {
        imageName = 13;
      }
      return Container(
        width: 580,
        height: 240,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: isHovered
                  ? Color.fromARGB(0, bgcolor.red, bgcolor.green, bgcolor.blue)
                  : bgcolor,
              borderRadius: BorderRadius.circular(20),
            ),
            duration: const Duration(milliseconds: 180),
            width: isHovered ? 580 : 540,
            height: isHovered ? 240 : 220,
            child: MouseRegion(
              onEnter: (event) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Stack(children: [
                Positioned(
                  top: 30,
                  left: 30,
                  width: 300,
                  height: 130,
                  child: Align(
                    alignment:
                        isHovered ? Alignment.bottomLeft : Alignment.centerLeft,
                    child: Text(
                      isHovered
                          ? "${minTemp.toStringAsFixed(2)}  -\n     ${maxTemp.toStringAsFixed(2)} °C"
                          : "$avgTemp °C",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontSize: isHovered ? 50 : 70,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 248, 255, 255)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 30,
                  child: Row(
                    children: [
                      const Icon(
                        color: Color.fromARGB(255, 251, 253, 255),
                        Icons.location_on,
                        size: 30,
                      ),
                      Text(
                        " ${capitalizeWords(currWeatherData.cityName)}, ${capitalizeWords(currWeatherData.cityCountry)}",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 30,
                  child: Text(
                    "${dateTime[0]} ${dateTime[1]} ${dateTime[2]} ${dateTime[3]}",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 30,
                  child: Text(
                    isHovered ? "${dateTime[4]}" : "",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 30,
                  child: Image.asset(
                    imageName <= 9
                        ? 'lib/images/icons/0$imageName$imageNameMode.png'
                        : 'lib/images/icons/$imageName$imageNameMode.png',
                    width: 90,
                    height: 90,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'lib/images/icons/notFound.png',
                        width: 90,
                        height: 90,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 30,
                  child: Text(
                    capitalizeWords(currWeatherData.weatherValue),
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 248, 255, 255)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}

class StatGraph extends StatefulWidget {
  const StatGraph({super.key});
  @override
  State<StatGraph> createState() => _statGraphState();
}

class _statGraphState extends State<StatGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      List<FlSpot> dataList = [];
      List<Color> dataListColors = [];
      List<String> dateList = [];
      int maxX =
          (value.weatherData.length > 20) ? (20) : (value.weatherData.length);
      int c = 0;
      for (int i = value.weatherData.length - maxX;
          i < value.weatherData.length;
          i++) {
        try {
          var avgTemp = value.weatherData[i].temperatureValue - 273.00;
          dataList.add(
              FlSpot(c.toDouble(), double.parse((avgTemp).toStringAsFixed(2))));
          var temp =
              (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
          dataListColors.add(Color.fromARGB(
              255,
              ((temp - 10) * (255 / 35)).round(),
              ((45 - temp) * (255 / 35) * (0.5)).round(),
              ((45 - temp) * (255 / 35)).round()));
          dateList.add(value.weatherData[i].dateTime);
          c++;
        } catch (e) {
          print(e);
        }
      }
      /*
        // for (int i = value.weatherData.length - 1; i >= 0; i--) {
        //   try {
        //     var avgTemp = value.weatherData[i].temperatureValue - 273.00;
        //     dataList.add(FlSpot(
        //         maxX.toDouble(), double.parse((avgTemp).toStringAsFixed(2))));
        //     var temp =
        //         (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
        //     dataListColors.add(Color.fromARGB(
        //         255,
        //         ((temp - 10) * (255 / 35)).round(),
        //         ((45 - temp) * (255 / 35) * (0.5)).round(),
        //         ((45 - temp) * (255 / 35)).round()));
        //     dateList.add(value.weatherData[i].dateTime);
        //     maxX++;
        //     if (maxX == 20) {
        //       break;
        //     }
        //   } catch (e) {
        //     print(e);
        //   }
        // }
      */
      return Container(
        width: 500,
        height: 320,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xff37434d),
                  width: 1.8,
                ),
              ),
            ),
            minX: 0,
            maxX: maxX.toDouble() - 1.0,
            minY: 0,
            maxY: 40,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: const Color.fromARGB(188, 255, 255, 255),
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  List<LineTooltipItem> tooltipItems = [];
                  for (LineBarSpot touchedSpot in touchedSpots) {
                    double x = touchedSpot.x;
                    double y = touchedSpot.y;
                    List date = dateList[x.toInt()].split(" ");
                    LineTooltipItem item = LineTooltipItem(
                      "${date[1]} ${date[2]} ,${date[4]}\n$y °c",
                      TextStyle(
                        color: Color.fromARGB(
                            255,
                            ((y - 10) * (255 / 35)).round(),
                            ((45 - y) * (255 / 35) * (0.5)).round(),
                            ((45 - y) * (255 / 35)).round()),
                        fontWeight: FontWeight.bold,
                      ),
                    );

                    tooltipItems.add(item);
                  }

                  return tooltipItems;
                },
              ),
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> indicators) {
                return indicators.map(
                  (int index) {
                    final line = FlLine(
                        color: Colors.grey,
                        strokeWidth: 1.5,
                        dashArray: [2, 4]);
                    return TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
            ),
            lineBarsData: [
              LineChartBarData(
                barWidth: 2.8,
                spots: dataList,
                isCurved: true,
                colors: dataListColors,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                    show: true,
                    colors: dataListColors.map((color) {
                      int red = color.red;
                      int green = color.green;
                      int blue = color.blue;
                      int alpha = color.alpha;

                      int newAlpha = (alpha * 0.35).round();
                      return Color.fromARGB(newAlpha, red, green, blue);
                    }).toList()),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ForecastTilesView extends StatefulWidget {
  const ForecastTilesView({super.key});

  @override
  State<ForecastTilesView> createState() => _ForecastTilesViewState();
}

class _ForecastTilesViewState extends State<ForecastTilesView> {
  int hoveredButtonIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      return Container(
          width: 760,
          height: 650,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              bool isHovered = index == hoveredButtonIndex;
              ForecastData currForecastData = value.forecastData[index];
              List dateTime = currForecastData.from.split(" ");
              var avgTemp = (currForecastData.tempValue - 273.00).round();
              var maxTemp = currForecastData.tempMax - 273;
              var minTemp = currForecastData.tempMin - 273;
              var temp =
                  (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
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
              return Padding(
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
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
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
                                  : capitalizeWords(
                                      currForecastData.symbolName),
                              style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                                    fontSize: isHovered ? 15 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ])),
                  ),
                ),
              );
            },
          ));
    });
  }
}

class AndroidWeatherDataTile extends StatefulWidget {
  const AndroidWeatherDataTile({Key? key}) : super(key: key);

  @override
  State<AndroidWeatherDataTile> createState() => _AndroidWeatherDataTileState();
}

class _AndroidWeatherDataTileState extends State<AndroidWeatherDataTile> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      WeatherData currWeatherData =
          value.weatherData[value.weatherData.length - 1];
      List dateTime = currWeatherData.dateTime.split(" ");
      var avgTemp = (currWeatherData.temperatureValue - 273.00).round();
      var maxTemp = currWeatherData.temperatureMax - 273;
      var minTemp = currWeatherData.temperatureMin - 273;
      var temp = (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
      var bgcolor = Color.fromARGB(
          255,
          ((temp - 10) * (255 / 35)).round(),
          ((45 - temp) * (255 / 35) * (0.5)).round(),
          ((45 - temp) * (255 / 35)).round());
      int imageName = int.parse(currWeatherData.weatherIcon
          .substring(0, currWeatherData.weatherIcon.length - 1));
      String imageNameMode = currWeatherData.weatherIcon.substring(
          currWeatherData.weatherIcon.length - 1,
          currWeatherData.weatherIcon.length);
      if (imageName >= 4 && imageName < 9) {
        imageName = 4;
      } else if (imageName >= 11 && imageName < 13) {
        imageName = 11;
      } else if (imageName >= 13 && imageName < 50) {
        imageName = 13;
      }

      return GestureDetector(
        onTap: toggleExpansion,
        child: Container(
          child: AnimatedContainer(
            width: isExpanded ? 377 : 351,
            height: isExpanded ? 156 : 143,
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: isExpanded ? Colors.transparent : bgcolor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  width: 195,
                  height: 85,
                  child: Align(
                    alignment: isExpanded
                        ? Alignment.bottomLeft
                        : Alignment.centerLeft,
                    child: Text(
                      isExpanded
                          ? "${minTemp.toStringAsFixed(2)}  -\n     ${maxTemp.toStringAsFixed(2)} °C"
                          : "$avgTemp °C",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                          fontSize: isExpanded ? 32 : 45,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 248, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Row(
                    children: [
                      const Icon(
                        color: Color.fromARGB(255, 251, 253, 255),
                        Icons.location_on,
                        size: 20,
                      ),
                      Text(
                        " ${capitalizeWords(currWeatherData.cityName)}, ${capitalizeWords(currWeatherData.cityCountry)}",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 20,
                  child: Text(
                    "${dateTime[0]} ${dateTime[1]} ${dateTime[2]} ${dateTime[3]}",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 42,
                  right: 20,
                  child: Text(
                    isExpanded ? "${dateTime[4]}" : "",
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 36,
                  right: 20,
                  child: Image.asset(
                    imageName <= 9
                        ? 'lib/images/icons/0$imageName$imageNameMode.png'
                        : 'lib/images/icons/$imageName$imageNameMode.png',
                    width: 54,
                    height: 54,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'lib/images/icons/notFound.png',
                        width: 54,
                        height: 54,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Text(
                    capitalizeWords(currWeatherData.weatherValue),
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 248, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AndroidStatGraph extends StatefulWidget {
  const AndroidStatGraph({Key? key}) : super(key: key);

  @override
  State<AndroidStatGraph> createState() => _AndroidStatGraphState();
}

class _AndroidStatGraphState extends State<AndroidStatGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      List<FlSpot> dataList = [];
      List<Color> dataListColors = [];
      List<String> dateList = [];
      int maxX =
          (value.weatherData.length > 20) ? (20) : (value.weatherData.length);
      int c = 0;
      for (int i = value.weatherData.length - maxX;
          i < value.weatherData.length;
          i++) {
        try {
          var avgTemp = value.weatherData[i].temperatureValue - 273.00;
          dataList.add(
              FlSpot(c.toDouble(), double.parse((avgTemp).toStringAsFixed(2))));
          var temp =
              (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
          dataListColors.add(Color.fromARGB(
              255,
              ((temp - 10) * (255 / 35)).round(),
              ((45 - temp) * (255 / 35) * (0.5)).round(),
              ((45 - temp) * (255 / 35)).round()));
          dateList.add(value.weatherData[i].dateTime);
          c++;
        } catch (e) {
          print(e);
        }
      }

      return Container(
        width: 325, // Adjusted pixel width
        height: 208, // Adjusted pixel height
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xff37434d),
                  width: 1.8,
                ),
              ),
            ),
            minX: 0,
            maxX: maxX.toDouble() - 1.0,
            minY: 0,
            maxY: 40,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: const Color.fromARGB(188, 255, 255, 255),
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  List<LineTooltipItem> tooltipItems = [];
                  for (LineBarSpot touchedSpot in touchedSpots) {
                    double x = touchedSpot.x;
                    double y = touchedSpot.y;
                    List date = dateList[x.toInt()].split(" ");
                    LineTooltipItem item = LineTooltipItem(
                      "${date[1]} ${date[2]} ,${date[4]}\n$y °c",
                      TextStyle(
                        color: Color.fromARGB(
                            255,
                            ((y - 10) * (255 / 35)).round(),
                            ((45 - y) * (255 / 35) * (0.5)).round(),
                            ((45 - y) * (255 / 35)).round()),
                        fontWeight: FontWeight.bold,
                      ),
                    );

                    tooltipItems.add(item);
                  }

                  return tooltipItems;
                },
              ),
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> indicators) {
                return indicators.map(
                  (int index) {
                    final line = FlLine(
                      color: Colors.grey,
                      strokeWidth: 1.5,
                      dashArray: [2, 4],
                    );
                    return TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
            ),
            lineBarsData: [
              LineChartBarData(
                barWidth: 2.8,
                spots: dataList,
                isCurved: true,
                colors: dataListColors,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  colors: dataListColors.map((color) {
                    int red = color.red;
                    int green = color.green;
                    int blue = color.blue;
                    int alpha = color.alpha;
                    int newAlpha = (alpha * 0.35).round();
                    return Color.fromARGB(newAlpha, red, green, blue);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AndroidForecastTilesView extends StatefulWidget {
  const AndroidForecastTilesView({Key? key});

  @override
  State<AndroidForecastTilesView> createState() =>
      _AndroidForecastTilesViewState();
}

class _AndroidForecastTilesViewState extends State<AndroidForecastTilesView> {
  int? tappedButtonIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, value, child) {
        return Column(
          children: List.generate(7, (index) {
            final isTapped = index == tappedButtonIndex;
            ForecastData currForecastData = value.forecastData[index];
            List dateTime = currForecastData.from.split(" ");
            var avgTemp = (currForecastData.tempValue - 273.00).round();
            var maxTemp = currForecastData.tempMax - 273;
            var minTemp = currForecastData.tempMin - 273;
            var temp =
                (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
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

            return Padding(
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
            );
          }),
        );
      },
    );
  }
}
