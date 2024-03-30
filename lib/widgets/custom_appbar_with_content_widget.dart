import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/extensions/extensions.dart';
import 'package:weather_app/models/models.dart';

import '../custom_painters/dot_with_line.dart';
import '../custom_painters/water_drop.dart';

class CustomAppBarWithContent extends StatelessWidget {
  const CustomAppBarWithContent({
    super.key,
    required this.scrollController,
    required this.padding,
    required this.animationController,
    required this.opacity,
    required this.currentWeather,
    required this.isDarkMode,
  });

  final CurrentWeatherResponse currentWeather;
  final ScrollController scrollController;
  final double padding;
  final AnimationController animationController;
  final double opacity;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    bool isDay = currentWeather.current.is_day == 1;
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          pinned: true,
          expandedHeight: kToolbarHeight * 5.4,
          collapsedHeight: kToolbarHeight * 2.5,
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (animationController.status ==
                                AnimationStatus.completed) {
                              await animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        AnimatedOpacity(
                          opacity: opacity,
                          duration: Duration.zero,
                          child: Row(
                            children: [
                              Text(
                                currentWeather.location.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _Temp(
                          currentWeather: currentWeather,
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: AnimatedOpacity(
                            opacity: opacity,
                            duration: Duration.zero,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${currentWeather.current.maxtemp_c.toInt()}º / ${currentWeather.current.mintemp_c.toInt()}º',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        currentWeather.current.condition.text,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Lottie.asset(
                                  getLottie(
                                    currentWeather.current.is_day,
                                    currentWeather.current.condition.code,
                                  ).small,
                                  // mapLotties[0]!.small,
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (1 - opacity > 0)
                      AnimatedOpacity(
                        opacity: 1 - opacity,
                        duration: Duration.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .55,
                              child: Text(
                                currentWeather.current.condition.text,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  currentWeather.location.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${currentWeather.current.maxtemp_c.toInt()}º / ${currentWeather.current.mintemp_c.toInt()}º Sensacion térmica ${currentWeather.current.feelslike_c.toInt()}°',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${weekDays[DateTime.now().weekday]}, ${DateTime.now().hour}:${DateTime.now().minute}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
                Positioned(
                  right: getLottie(
                    currentWeather.current.is_day,
                    currentWeather.current.condition.code,
                  ).right,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: 1 - opacity,
                    duration: Duration.zero,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          getLottie(
                            currentWeather.current.is_day,
                            currentWeather.current.condition.code,
                          ).percentage,
                      child: Lottie.asset(
                        getLottie(
                          currentWeather.current.is_day,
                          currentWeather.current.condition.code,
                        ).big,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.list(
          children: [
            _Card(
              margin: EdgeInsets.symmetric(horizontal: padding * .5),
              height: 211,
              padding: padding,
              isDarkMode: isDarkMode,
              isDay: isDay,
              child: ForecastChart(currentWeather: currentWeather),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: padding * .5),
              height: 295,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4 / 3,
                children: [
                  _Card(
                    margin: EdgeInsets.zero,
                    height: 0,
                    padding: padding,
                    isDarkMode: isDarkMode,
                    isDay: isDay,
                    child: _GridContent(
                      title: "Indice UV",
                      subTitle: indexUv[currentWeather.current.uv.toInt()]!,
                      imageUrl:
                          "https://cdn.icon-icons.com/icons2/1441/PNG/128/sun_98674.png",
                    ),
                  ),
                  _Card(
                    margin: EdgeInsets.zero,
                    height: 0,
                    padding: padding,
                    isDarkMode: isDarkMode,
                    isDay: isDay,
                    child: _GridContent(
                      title: "Humedad",
                      subTitle: "${currentWeather.current.humidity} %",
                      imageUrl:
                          "https://cdn.icon-icons.com/icons2/527/PNG/512/Humidity_icon-icons.com_52507.png",
                    ),
                  ),
                  _Card(
                    margin: EdgeInsets.zero,
                    height: 0,
                    padding: padding,
                    isDarkMode: isDarkMode,
                    isDay: isDay,
                    child: _GridContent(
                      title: "Viento",
                      subTitle: "${currentWeather.current.wind_kph} km/h",
                      imageUrl:
                          "https://cdn.icon-icons.com/icons2/520/PNG/512/Weather-wind_icon-icons.com_51816.png",
                      imageHeight: 40,
                      spacer: const SizedBox(height: 10),
                    ),
                  ),
                  _Card(
                    margin: EdgeInsets.zero,
                    height: 0,
                    padding: padding,
                    isDarkMode: isDarkMode,
                    isDay: isDay,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _GridContent(
                          title: "Amanecer",
                          subTitle: currentWeather.current.sunrise,
                          imageUrl:
                              "https://cdn.icon-icons.com/icons2/2527/PNG/512/sun_sunshine_sunrise_icon_151789.png",
                          imageHeight: 45,
                          spacer: const SizedBox(height: 10),
                        ),
                        _GridContent(
                          title: "Atardecer",
                          subTitle: currentWeather.current.sunset,
                          imageUrl:
                              "https://cdn.icon-icons.com/icons2/2527/PNG/512/sunrise_weather_icon_151777.png",
                          imageHeight: 45,
                          spacer: const SizedBox(height: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _Card(
              padding: padding,
              height: 500,
              isDarkMode: isDarkMode,
              isDay: isDay,
              margin: EdgeInsets.symmetric(horizontal: padding * .5),
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }

  LottieImages getLottie(int isDay, int code) {
    if (isDay != 1) {
      bool exist = mapLottiesNight.containsKey(code);
      if (!exist) return mapLottiesNight.values.first;
      return mapLottiesNight[code]!;
    } else {
      bool exist = mapLottiesDay.containsKey(code);
      if (!exist) return mapLottiesDay.values.first;
      return mapLottiesDay[code]!;
    }
  }
}

class _GridContent extends StatelessWidget {
  const _GridContent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    this.imageHeight = 60,
    this.spacer = const SizedBox(),
  });

  final String title;
  final String subTitle;
  final String imageUrl;
  final double imageHeight;
  final Widget spacer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          imageUrl,
          height: imageHeight,
        ),
        spacer,
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    super.key,
    required this.padding,
    required this.height,
    required this.isDarkMode,
    required this.isDay,
    required this.child,
    required this.margin,
  });

  final double padding;
  final double height;
  final bool isDarkMode;
  final bool isDay;
  final Widget child;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: !isDarkMode
            ? isDay
                ? const Color(0xff61a4f2)
                : const Color(0xff3c4274)
            : const Color(0xff171717),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class ForecastChart extends StatelessWidget {
  const ForecastChart({
    super.key,
    required this.currentWeather,
  });

  final CurrentWeatherResponse currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${currentWeather.current.condition.text}. Mínima ${currentWeather.current.mintemp_c.toInt()} C.',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(thickness: .2),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var isFirst = index == 0;
              var isLast = index + 1 == currentWeather.forecast.hours.length;

              return Column(
                children: [
                  Text(
                    currentWeather.forecast.hours[index].time.getHours(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Image.network(
                    currentWeather.forecast.hours[index].condition.icon,
                    height: 53,
                  ),
                  Text(
                    "${currentWeather.forecast.hours[index].temp_c.toInt()} Cº",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    // color: Colors.red,
                    height: 15,
                    width: 53,
                    child: CustomPaint(
                      painter: DotWithLine(
                        isFirst: isFirst,
                        isLast: isLast,
                        temp:
                            currentWeather.forecast.hours[index].temp_c.toInt(),
                        nextTemp: isLast
                            ? currentWeather.forecast.hours[index].temp_c
                                .toInt()
                            : currentWeather.forecast.hours[index + 1].temp_c
                                .toInt(),
                        minTemp: currentWeather.forecast.minTemp,
                        maxTemp: currentWeather.forecast.maxTemp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: SizedBox(
                          height: 15,
                          width: 20,
                          child: CustomPaint(
                            painter: GotaDeAguaPainter(),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 5),
                      Text(
                        "${currentWeather.forecast.hours[index].chance_of_rain} %",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: currentWeather.forecast.hours.length,
            // itemCount: 2,
          ),
        ),
      ],
    );
  }
}

final mapLottiesDay = {
  1000: LottieImages(
    big: 'assets/person-in-beach.json',
    small: 'assets/sun3.json',
    right: 0,
    percentage: .4,
  ),
  1003: LottieImages(
    big: 'assets/person-in-beach.json',
    small: 'assets/sun-with-cloud.json',
    right: 0,
    percentage: .4,
  ),
  1006: LottieImages(
    big: 'assets/hot-air-baloon.json',
    small: 'assets/sun-with-cloud.json',
    right: -60,
    percentage: .7,
  ),
};

final mapLottiesNight = {
  1000: LottieImages(
    big: 'assets/moon.json',
    small: 'assets/moon-with-stars.json',
    right: -60,
    percentage: .7,
  ),
};

class _Temp extends StatefulWidget {
  const _Temp({
    super.key,
    required this.currentWeather,
    required this.isDarkMode,
  });

  final CurrentWeatherResponse currentWeather;
  final bool isDarkMode;

  @override
  State<_Temp> createState() => _TempState();
}

class _TempState extends State<_Temp> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween(begin: 70.0, end: 70.0 / 1.5).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDarkMode) {
      controller.forward();
    } else {
      controller.reverse();
    }
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Text(
        '${widget.currentWeather.current.temp_c.toInt()}º',
        style: TextStyle(
          color: Colors.white,
          fontSize: animation.value,
          height: 1.2,
        ),
      ),
    );
  }
}

class LottieImages {
  final String big;
  final String small;
  final double right;
  final double percentage;

  LottieImages({
    required this.big,
    required this.small,
    required this.right,
    required this.percentage,
  });
}

final weekDays = {
  1: 'lun',
  2: 'mar',
  3: 'mié',
  4: 'jue',
  5: 'vie',
  6: 'sáb',
  7: 'dom',
};

final Map<int, String> indexUv = {
  1: "Bajo",
  2: "Bajo",
  3: "Medio",
  4: "Medio",
  5: "Medio",
  6: "Alto",
  7: "Alto",
  8: "Muy Alto",
  9: "Muy Alto",
  10: "Muy Alto",
  11: "Extremadamente alto",
};
