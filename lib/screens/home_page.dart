import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataModel>(builder: (context, value, child) {
//       return Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) {
//                 return SetLocationPage();
//               }));
//             },
//           ),
//         ),
//         body: value.dataFetchedOnce
//             ? CustomDataTiles()
//             : FutureBuilder<int>(
//                 future: Provider.of<DataModel>(context, listen: false)
//                     .fetchWeatherData(),
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.done:
//                       print("from fetchData : ${snapshot.data}");
//                       if (snapshot.data == 0) {
//                         return CustomDataTiles();
//                       } else {
//                         return const Center(
//                           child: Text(
//                               "Problem in fetching data from server...Did you set the location correctly?"),
//                         );
//                       }

//                     default:
//                       return Scaffold(
//                         body: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Loading...",
//                             style: GoogleFonts.notoSans(
//                               textStyle: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 26, 141, 255),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                   }
//                 },
//               ),
//       );
//     });
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 77, 172),
        appBar: AppBar(
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
                padding: EdgeInsets.only(top: 20), child: WeatherDataTile())
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
                            child: WeatherDataTile());
                      } else {
                        return const Center(
                          child: Text(
                              "Problem in fetching data from server...Did you set the location correctly?"),
                        );
                      }

                    default:
                      return Scaffold(
                        body: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Loading...",
                            style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 26, 141, 255),
                              ),
                            ),
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
      var avgTemp = currWeatherData.temperatureValue.round() - 273;
      var maxTemp = currWeatherData.temperatureMax - 273;
      var minTemp = currWeatherData.temperatureMin - 273;
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
        width: 550,
        height: 240,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: isHovered
                  ? Colors.transparent
                  : Color.fromARGB(30, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            duration: const Duration(milliseconds: 180),
            width: isHovered ? 550 : 480,
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
                  top: 50,
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

// class CustomDataTiles extends StatelessWidget {
//   const CustomDataTiles({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataModel>(builder: (context, value, child) {
//       List<WeatherData> weatherDataList = value.weatherData;
//       return Row(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: weatherDataList.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20, bottom: 20, left: 60, right: 60),
//                   child: Container(
//                     height: 80,
//                     color: Colors.blue,
//                     child: Row(children: [
//                       Container(
//                         width: 40,
//                       ),
//                       Text(
//                         weatherDataList[index].dateTime,
//                         style: GoogleFonts.notoSans(
//                           textStyle: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 10,
//                       ),
//                       Text(
//                         weatherDataList[index].cityName,
//                         style: GoogleFonts.notoSans(
//                           textStyle: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 10,
//                       ),
//                       Text(
//                         "${weatherDataList[index].tempMax} K",
//                         style: GoogleFonts.notoSans(
//                           textStyle: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 10,
//                       ),
//                       Text(
//                         weatherDataList[index].weatherValue,
//                         style: GoogleFonts.notoSans(
//                           textStyle: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

/*
  class HomeScreen extends StatefulWidget {
    String cityName;
    HomeScreen(this.cityName);
    @override
    _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    List<WeatherData> weatherDataList = [];

    @override
    void initState() {
      super.initState();
      fetchData(widget.cityName);
    }

    Future<void> fetchData(String cityName) async {
      final response = await http.get(Uri.parse(
          'http://localhost:5000/api/weather?city_name=${cityName.toLowerCase()}'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedJson = jsonDecode(response.body.toString());
        setState(() {
          weatherDataList =
              parsedJson.map((json) => WeatherData.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return SetLocationPage();
                  }));
                },
              ),
              title: Text("Weather Forcast")),
          body: (weatherDataList.length <= 0)
              ? (const Row(
                  children: [Text("Loading Data"), CircularProgressIndicator()],
                ))
              : (Row(
                  children: [
                    Container(
                      width: 1000,
                      child: ListView.builder(
                        itemCount: weatherDataList.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Container(
                              child: Column(children: [
                                Text(weatherDataList[index].dateTime),
                                Text(weatherDataList[index].cityId),
                                Text(weatherDataList[index].cityName),
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.center, child: ButtonStack())),
                  ],
                )));
    }
  }
*/

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

class demoScreen extends StatelessWidget {
  const demoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Data Display"),
        ),
        body: FutureBuilder<int>(
          future: Provider.of<DataModel>(context, listen: false)
              .setCityNameGeolocate(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still running, display a loading indicator
              return const Row(
                children: [
                  Text("Getting Location"),
                  CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.hasError) {
              // If there is an error while fetching data, display an error message
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.done) {
              // If the Future has completed successfully, display the city name
              print("snapshot.data ${snapshot.data}");
              if (snapshot.data == 0) {
                return Consumer<DataModel>(builder: (context, value, child) {
                  print("value.cityName = ${value.cityName}");
                  return HomeScreen();
                });
              } else {
                return Text("error in getcityname");
              }
            } else {
              return Text("Some Problem Occured");
            }
          },
        ));
  }
}
