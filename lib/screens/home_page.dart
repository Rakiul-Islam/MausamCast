import 'package:fl_chart/fl_chart.dart';
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 29, 66),
        extendBodyBehindAppBar: true,
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
                future: Provider.of<DataModel>(context, listen: false)
                    .fetchWeatherData(),
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
    return const SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: 40, bottom: 5, right: 40, left: 55),
                    child: WeatherDataTile()),
                Padding(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 10, right: 40, left: 55),
                    child: StatGraph())
              ],
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 28, bottom: 16, right: 40, left: 30),
                child: ForecastTilesView())
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
      print("$imageName and $imageNameMode");
      return Container(
        width: 580,
        height: 240,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: isHovered ? Colors.transparent : bgcolor,
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
      int maxX = 0;
      for (int i = value.weatherData.length - 1; i >= 0; i--) {
        try {
          var avgTemp = value.weatherData[i].temperatureValue - 273.00;
          dataList.add(FlSpot(
              maxX.toDouble(), double.parse((avgTemp).toStringAsFixed(2))));
          var temp =
              (avgTemp > 45) ? (45) : ((avgTemp < 10) ? (10) : (avgTemp));
          dataListColors.add(Color.fromARGB(
              255,
              ((temp - 10) * (255 / 35)).round(),
              ((45 - temp) * (255 / 35) * (0.5)).round(),
              ((45 - temp) * (255 / 35)).round()));
          dateList.add(value.weatherData[i].dateTime);
          maxX++;
          if (maxX == 20) {
            break;
          }
        } catch (e) {
          print(e);
        }
      }

      return Container(
        width: 500,
        height: 360,
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
            maxY: 50,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750,
      height: 650,
      color: Colors.amber,
    );
  }
}

class ButtonStack extends StatefulWidget {
  @override
  _ButtonStackState createState() => _ButtonStackState();
}

class _ButtonStackState extends State<ButtonStack> {
  int hoveredButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: i == hoveredButtonIndex ? 150.0 : 100.0,
            height: i == hoveredButtonIndex ? 60.0 : 40.0,
            color: i == hoveredButtonIndex ? Colors.blue : Colors.grey,
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  hoveredButtonIndex = i;
                });
              },
              onExit: (_) {
                setState(() {
                  hoveredButtonIndex = -1;
                });
              },
              child: Center(
                child: Text(
                  'Button $i',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
