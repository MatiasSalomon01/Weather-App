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
                                  mapLotties[0]!.small,
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
                          ],
                        ),
                      )
                  ],
                ),
                Positioned(
                  right: mapLotties[currentWeather.current.is_day]!.right,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: 1 - opacity,
                    duration: Duration.zero,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          mapLotties[currentWeather.current.is_day]!.percentage,
                      child: Lottie.asset(
                        mapLotties[currentWeather.current.is_day]!.big,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   top: 0,
                //   child: AnimatedOpacity(
                //     opacity: 1,
                //     duration: Duration.zero,
                // child: Lottie.asset(
                //   'assets/person-in-beach.json',
                //   height: 100,
                // ),
                //   ),
                // ),
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

final mapLotties = {
  0: LottieImages(
    big: 'assets/moon.json',
    small: 'assets/moon-with-stars.json',
    right: -60,
    percentage: .7,
  ),
  1: LottieImages(
    big: 'assets/person-in-beach.json',
    small: 'assets/sun3.json',
    right: 0,
    percentage: .4,
  ),
  2: LottieImages(
    big: 'assets/moon.json',
    small: 'assets/moon-with-stars.json',
    right: -60,
    percentage: .7,
  ),
};

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
