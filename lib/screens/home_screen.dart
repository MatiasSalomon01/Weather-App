import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController controller;
  double opacity = 0;
  double padding = 20;
  bool isDarkMode = false;

  final lightDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xff63608f), Color(0xff49528b)],
      stops: [.1, .5],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  final darkDecoration = const BoxDecoration(
    color: Color(0xff010101),
  );

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    opacity = (controller.offset / 45).clamp(0, 1);

    if (controller.offset.clamp(0, kToolbarHeight * 2.5) ==
            kToolbarHeight * 2.5 &&
        context.read<ThemeProvider>().isDarkMode == false) {
      context.read<ThemeProvider>().isDarkMode = true;
    }

    if (controller.offset.clamp(0, kToolbarHeight * 2.5) == 0 &&
        context.read<ThemeProvider>().isDarkMode == true) {
      context.read<ThemeProvider>().isDarkMode = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: !context.read<ThemeProvider>().isDarkMode
                ? const LinearGradient(
                    colors: [Color(0xff63608f), Color(0xff49528b)],
                    stops: [.1, .5],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: kToolbarHeight * 5,
              collapsedHeight: kToolbarHeight * 2.5,
              flexibleSpace: SafeArea(
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(width: 20),
                                AnimatedOpacity(
                                  opacity: opacity,
                                  duration: Duration.zero,
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Lambare',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
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
                                const Text(
                                  '29º',
                                  style: TextStyle(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '34º / 22º',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              'Despejado',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Lottie.asset(
                                          'assets/moon-with-stars.json',
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
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Despejado',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'Lambare',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        SizedBox(width: 3),
                                        Icon(
                                          Icons.location_on_sharp,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '34º / 22º Sensacion termica 31º',
                                      style: TextStyle(
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
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: padding * .5),
                height: 150,
                decoration: BoxDecoration(
                    color: !context.read<ThemeProvider>().isDarkMode
                        ? const Color(0xff3c4274)
                        : const Color(0xff171717),
                    borderRadius: BorderRadius.circular(20)),
              ),
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            )
          ],
        ),
      ),
    );
  }
}
