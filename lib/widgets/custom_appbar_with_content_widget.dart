import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/models.dart';

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
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          pinned: true,
          expandedHeight: kToolbarHeight * 5,
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
                        Text(
                          '${currentWeather.current.temp_c}º',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            height: 1.2,
                          ),
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
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                    'assets/moon-with-stars.json',
                                    height: 80,
                                  ),
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
                            Text(
                              currentWeather.current.condition.text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  currentWeather.location.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
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
                                  color: Colors.white70, fontSize: 15),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
                Positioned(
                  right: -60,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: 1 - opacity,
                    duration: Duration.zero,
                    child: Lottie.asset(
                      'assets/moon.json',
                      height: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: padding * .5),
            height: 150,
            decoration: BoxDecoration(
                color: !isDarkMode
                    ? const Color(0xff3c4274)
                    : const Color(0xff171717),
                borderRadius: BorderRadius.circular(20)),
          ),
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        )
      ],
    );
  }
}
