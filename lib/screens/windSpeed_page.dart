import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/modules/data_model.dart';
import 'package:my_weather_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class WindSpeedGraphPage extends StatefulWidget {
  const WindSpeedGraphPage({super.key});

  @override
  State<WindSpeedGraphPage> createState() => _WindSpeedGraphPageState();
}

class _WindSpeedGraphPageState extends State<WindSpeedGraphPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<WeatherData> weatherData =
        Provider.of<DataModel>(context, listen: false).weatherData;
    double maxWindSpeed = weatherData[0].windSpeedValue;
    double minWindSpeed = weatherData[0].windSpeedValue;
    for (int i = 0; i < weatherData.length; i++) {
      if (weatherData[i].windSpeedValue > maxWindSpeed) {
        maxWindSpeed = weatherData[i].windSpeedValue;
      }
      if (weatherData[i].windSpeedValue < minWindSpeed) {
        minWindSpeed = weatherData[i].windSpeedValue;
      }
    }
    print("min = $minWindSpeed");
    print("max = $maxWindSpeed");
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: (MediaQuery.of(context).orientation ==
                    Orientation.landscape &&
                !kIsWeb)
            ? Container()
            : Padding(
                padding: EdgeInsets.only(
                    top: (kIsWeb ||
                            MediaQuery.of(context).orientation ==
                                Orientation.landscape)
                        ? 0
                        : 100),
                child: (!kIsWeb)
                    ? SizedBox(
                        height: 300,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 5,
                                          bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (maxWindSpeed < 2)
                                              ? Color.fromARGB(
                                                  160,
                                                  60,
                                                  ((255) * (2 / 5) * 0.85)
                                                      .round(),
                                                  ((255) * (2 / 5) * 0.8)
                                                      .round())
                                              : Color.fromARGB(
                                                  160,
                                                  60,
                                                  ((255) *
                                                          (maxWindSpeed / 5) *
                                                          0.85)
                                                      .round(),
                                                  ((255) *
                                                          (maxWindSpeed / 5) *
                                                          0.8)
                                                      .round()),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: 200,
                                        height: 56,
                                        child: Center(
                                          child: Text(
                                            "$maxWindSpeed m/s",
                                            style: GoogleFonts.notoSans(
                                              textStyle: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 196, 192, 192),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        color:
                                            Color.fromARGB(92, 255, 255, 255),
                                        Icons.arrow_downward,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Icon(
                                        color:
                                            Color.fromARGB(92, 255, 255, 255),
                                        Icons.arrow_upward,
                                        size: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 5, bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (minWindSpeed < 2)
                                              ? Color.fromARGB(
                                                  160,
                                                  60,
                                                  ((255) * (2 / 5) * 0.85)
                                                      .round(),
                                                  ((255) * (2 / 5) * 0.8)
                                                      .round())
                                              : Color.fromARGB(
                                                  160,
                                                  60,
                                                  ((255) *
                                                          (minWindSpeed / 5) *
                                                          0.85)
                                                      .round(),
                                                  ((255) *
                                                          (minWindSpeed / 5) *
                                                          0.8)
                                                      .round()),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: 200,
                                        height: 56,
                                        child: Center(
                                          child: Text(
                                            "$minWindSpeed m/s",
                                            style: GoogleFonts.notoSans(
                                              textStyle: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 196, 192, 192),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      )
                    : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (minWindSpeed < 2)
                                  ? Color.fromARGB(
                                      160,
                                      60,
                                      ((255) * (2 / 5) * 0.85).round(),
                                      ((255) * (2 / 5) * 0.8).round())
                                  : Color.fromARGB(
                                      160,
                                      60,
                                      ((255) * (minWindSpeed / 5) * 0.85)
                                          .round(),
                                      ((255) * (minWindSpeed / 5) * 0.8)
                                          .round()),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 180,
                            height: 40,
                            child: Center(
                              child: Text(
                                "$minWindSpeed m/s",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 196, 192, 192),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          color: Color.fromARGB(92, 255, 255, 255),
                          Icons.compare_arrows,
                          size: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (maxWindSpeed < 2)
                                  ? Color.fromARGB(
                                      160,
                                      60,
                                      ((255) * (2 / 5) * 0.85).round(),
                                      ((255) * (2 / 5) * 0.8).round())
                                  : Color.fromARGB(
                                      160,
                                      60,
                                      ((255) * (maxWindSpeed / 5) * 0.85)
                                          .round(),
                                      ((255) * (maxWindSpeed / 5) * 0.8)
                                          .round()),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 180,
                            height: 40,
                            child: Center(
                              child: Text(
                                "$maxWindSpeed m/s",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 196, 192, 192),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
              ),
        key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 0, 29, 66),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: kIsWeb
                        ? 100
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 300
                            : 20,
                    bottom: (kIsWeb ||
                            MediaQuery.of(context).orientation ==
                                Orientation.landscape)
                        ? 40
                        : 20,
                    left: kIsWeb
                        ? 20
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 10
                            : 50,
                    right: kIsWeb
                        ? 20
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 10
                            : 20,
                  ),
                  child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: WindSpeedGraph()))),
        ));
  }
}

class WindSpeedGraph extends StatelessWidget {
  const WindSpeedGraph({super.key});
  @override
  Widget build(BuildContext context) {
    List<WeatherData> revweatherData =
        Provider.of<DataModel>(context, listen: false)
            .weatherData
            .reversed
            .toList();

    revweatherData = (revweatherData.length >= 100)
        ? revweatherData.sublist(0, 99)
        : revweatherData;
    List<FlSpot> dataList = [];
    List<Color> dataListColors = [];
    List<String> dateList = [];
    int maxX = revweatherData.length;
    int c = 0;
    for (int i = revweatherData.length - maxX; i < revweatherData.length; i++) {
      try {
        double windSpeed = revweatherData[i].windSpeedValue;
        dataList.add(
            FlSpot(c.toDouble(), double.parse((windSpeed).toStringAsFixed(2))));
        dataListColors.add((windSpeed < 2)
            ? Color.fromARGB(255, 60, ((255) * (2 / 5) * 0.85).round(),
                ((255) * (2 / 5) * 0.8).round())
            : Color.fromARGB(255, 60, ((255) * (windSpeed / 5) * 0.85).round(),
                ((255) * (windSpeed / 5) * 0.8).round()));
        dateList.add(revweatherData[i].dateTime);
        c++;
      } catch (e) {
        print(e);
      }
    }
    return SizedBox(
      width: 20 * revweatherData.length.toDouble(),
      height: kIsWeb ? 600 : 450,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            horizontalInterval: 0.4, // Customize the horizontal grid interval
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              // Define the color for the horizontal gridlines
              if (value == 0 || value >= 105) {
                return FlLine(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  strokeWidth: 0.8,
                );
              } else {
                return FlLine(
                  color: (value < 2)
                      ? Color.fromARGB(
                          160,
                          60,
                          ((255) * (2 / 5) * 0.85).round(),
                          ((255) * (2 / 5) * 0.8).round())
                      : Color.fromARGB(
                          160,
                          60,
                          ((255) * (value / 5) * 0.85).round(),
                          ((255) * (value / 5) * 0.8)
                              .round()), // Specify your desired color here
                  strokeWidth: 1.0, // Adjust the line thickness
                );
              }
            },
          ),
          titlesData: FlTitlesData(
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              reservedSize: 20,
              showTitles: true,
              getTextStyles: (context, value) {
                Color x = const Color.fromARGB(109, 255, 255, 255);
                return GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: x,
                  ),
                );
              },
              getTitles: (value) {
                if (value == 0 || value == maxX) {
                  return "";
                }
                List dateTime = dateList[value.toInt()].split(" ");
                return "${dateTime[0]} ${dateTime[1]} ${dateTime[2]}";
              },
              interval: 10, // Customize the interval as needed

              margin: 10, // Reduce the margin to make the titles fit
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) {
                Color x = (value < 2)
                    ? Color.fromARGB(160, 60, ((255) * (2 / 5) * 0.85).round(),
                        ((255) * (2 / 5) * 0.8).round())
                    : Color.fromARGB(
                        160,
                        60,
                        ((255) * (value / 5) * 0.85).round(),
                        ((255) * (value / 5) * 0.8).round());
                return GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: x,
                  ),
                );
              },
              getTitles: (value) {
                if (value == 0 || value >= 5.4) {
                  return "";
                }
                return "${value.toStringAsFixed(1)} ";
              },
              interval: 0.4, // Customize the interval as needed
              reservedSize: 50, // Increase this size to fit the vertical text
              margin: 10, // Reduce the margin to make the titles fit
            ),
          ),
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
          maxX: maxX.toDouble() ,
          minY: 0,
          maxY: 6,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipBgColor: const Color.fromARGB(188, 255, 255, 255),
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                List<LineTooltipItem> tooltipItems = [];
                for (LineBarSpot touchedSpot in touchedSpots) {
                  double x = touchedSpot.x;
                  double y = touchedSpot.y;
                  List date = dateList[x.toInt()].split(" ");
                  LineTooltipItem item = LineTooltipItem(
                    "${date[1]} ${date[2]} ,${date[4]}\n$y m/s",
                    TextStyle(
                      color: (y < 2)
                          ? Color.fromARGB(
                              255,
                              40,
                              ((255) * (2 / 5) * 0.5).round(),
                              ((255) * (2 / 5) * 0.5).round())
                          : Color.fromARGB(
                              255,
                              40,
                              ((255) * (y / 5) * 0.5).round(),
                              ((255) * (y / 5) * 0.5).round()),
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
                      color: Colors.grey, strokeWidth: 1.5, dashArray: [2, 4]);
                  return TouchedSpotIndicatorData(
                    line,
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        // Define a custom dot painter
                        return FlDotCirclePainter(
                          strokeWidth: 0.0,
                          color: dataListColors[index],
                        );
                      },
                    ),
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

                    int newAlpha = (alpha * 0.2).round();
                    int newBlue = (blue * 0.8).round();
                    int newGreen = (green * 0.7).round();
                    return Color.fromARGB(newAlpha, red, newGreen, newBlue);
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
