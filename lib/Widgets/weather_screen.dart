import 'package:flutter/material.dart';
import 'package:flutter_application_2/Widgets/model/weather_model.dart';
import 'package:flutter_application_2/Widgets/weather_api.dart';
import 'package:flutter_application_2/Widgets/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = const Color.fromARGB(255, 127, 156, 252);
    var sd = const Color.fromARGB(255, 71, 114, 255);
    var sv = const Color.fromARGB(255, 10, 40, 139);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            s,
            sd,
            sv,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: BlocProvider(
                create: (context) => WeatherBloc(WeatherApi()),
                child: const SearchPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _Gradient extends StatelessWidget {
  Weather weatherModel;
  _Gradient(this.weatherModel);
  @override
  Widget build(BuildContext context) {
    var color1 = const Color.fromARGB(255, 127, 156, 252);
    var color2 = const Color.fromARGB(255, 71, 114, 255);
    var color3 = const Color.fromARGB(255, 10, 40, 139);
    String weatherCondition = weatherModel.weather[0].main.toString();
    switch (weatherCondition) {
      case ('Rain'):
        break;

      default:
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          color1,
          color2,
          color3,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }
}

class _ParametersWidget extends StatelessWidget {
  Weather weatherModel;

  final String city;
  _ParametersWidget(this.weatherModel, this.city);

  @override
  Widget build(BuildContext context) {
    String weatherCondition = weatherModel.weather[0].main.toString();
    String conditionImage;

    switch (weatherCondition) {
      case ('Rain'):
        weatherCondition = 'Дождь';
        conditionImage = 'assets/rain.png';
        break;
      case ('Drizzle'):
        weatherCondition = 'Дождь';
        conditionImage = 'assets/rain.png';
        break;
      case ('Thunderstorm'):
        weatherCondition = 'Гроза';
        conditionImage = 'assets/lightning.png';
        break;
      case ('Snow'):
        weatherCondition = 'Снег';
        conditionImage = 'assets/snow.png';
        break;
      case ('Clouds'):
        weatherCondition = 'Облачно';
        conditionImage = 'assets/clouds.png';
        break;
      default:
        weatherCondition = 'Ясно';
        conditionImage = 'assets/sunny.png';
    }
    var date = DateTime.now();

    int unixSunrise = weatherModel.sys.sunrise;
    int unixSunset = weatherModel.sys.sunset;
    DateTime sunriseDate = DateTime.fromMillisecondsSinceEpoch(
        unixSunrise * 1000 -
            date.timeZoneOffset.inMilliseconds +
            (weatherModel.timezone * 1000));
    DateTime sunsetDate = DateTime.fromMillisecondsSinceEpoch(
        unixSunset * 1000 -
            date.timeZoneOffset.inMilliseconds +
            (weatherModel.timezone * 1000));
    String dateformatSunrise = DateFormat.Hm().format(sunriseDate);
    String dateformatSunset = DateFormat.Hm().format(sunsetDate);

    _ParametersWidget(weatherModel, city);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherModel.main.temp.round().toString(),
                  style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
                const Text(
                  '\u2103',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ]),
        ),
        Text(
          weatherCondition,
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Image(
          image: AssetImage(conditionImage),
          width: 50,
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            padding: EdgeInsets.all(20),
            width: 322,
            child: Column(children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 16)),
                  Image.asset(
                    'assets/sunrise.png',
                    width: 50,
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 150),
                  ),
                  Image.asset(
                    'assets/sunset.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Восход ' + dateformatSunrise,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  Text(
                    'Закат ' + dateformatSunset,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Макс. температура:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  weatherModel.main.tempMax.round().toString() + '\u00B0',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Мин. температура:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  weatherModel.main.tempMin.round().toString() + '\u00B0',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Влажность',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  weatherModel.main.humidity.toString() + '%',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Давление',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  (weatherModel.main.pressure.toDouble() * 0.75006156)
                          .toInt()
                          .toString() +
                      ' мм. рт. ст.',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Скорость ветра',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  weatherModel.wind.speed.round().toString() + ' м/с',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ]),
            ])),
      ],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  String city = "Погода";
  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Column(
      children: [
        AppBar(
          title: Text(
            city,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 30),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        Center(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                style: const TextStyle(fontSize: 20, color: Colors.white),
                controller: cityController,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hintStyle:
                        const TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Введите город',
                    suffixIcon: IconButton(
                        onPressed: () {
                          city = cityController.text;
                          if (city.isNotEmpty) {
                            city = city.capitalize();
                          } else {
                            city = 'Погода';
                          }
                          weatherBloc.add(FetchWeather(cityController.text));

                          setState(() {
                            AppBar(
                              title: Text(city),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ))),
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherIsNotSearched) {
              return const Text('Данные не найдены',
                  style: TextStyle(fontSize: 20, color: Colors.white));
            } else if (state is WeatherIsLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            } else if (state is WeatherIsLoaded) {
              return _ParametersWidget(state.getWeather, cityController.text);
            } else if (state is WeatherInputCity) {
              return const Text('Введите город',
                  style: TextStyle(fontSize: 20, color: Colors.white));
            } else {
              return const Text('Ошибка',
                  style: TextStyle(fontSize: 20, color: Colors.white));
            }
          },
        ),
      ],
    );
  }
}
