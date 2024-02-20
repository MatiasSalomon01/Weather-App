import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  double opacity = 0;
  double padding = 20;
  bool isDarkMode = false;
  late final ThemeProvider themeProvider;
  late final AnimationController animationController;
  late Animation<double> dxAnimation;
  late Animation<double> dxAnimationDrawer;
  final double end = 314.0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
    themeProvider = context.read<ThemeProvider>();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController.addListener(() {
      setState(() {});
    });

    dxAnimation = Tween(begin: 0.0, end: end).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    dxAnimationDrawer = Tween(begin: -end, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    opacity = (scrollController.offset / 40).clamp(0, 1);
    setState(() {});

    if (scrollController.offset > kToolbarHeight * 2 &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        !themeProvider.isDarkMode) {
      themeProvider.isDarkMode = true;
    }

    if (scrollController.offset < kToolbarHeight * 2 &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        themeProvider.isDarkMode) {
      themeProvider.isDarkMode = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (context, state, child) => Stack(
          children: [
            Transform.translate(
              offset: Offset(dxAnimationDrawer.value, 0),
              child: SafeArea(
                child: Container(
                  // margin: EdgeInsets.only(left: 10),
                  height: size.height,
                  width: end - 5,
                  decoration: BoxDecoration(
                    color: !state.isDarkMode
                        ? const Color(0xff63608f)
                        : const Color(0xff171717),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    children: [
                      const SizedBox(height: 13),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.settings,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'Ubicacion favorita',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Lambare',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/cloud-and-sun.png',
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '33º',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: .5,
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'Otras ubicaciones',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 40),
                          const Text(
                            'Lambare',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/cloud-and-sun.png',
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '33º',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white12),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 0))),
                        onPressed: () {},
                        child: const Text(
                          'Administrar ubicaciones',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: .5,
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Ubicacion correcta',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Transform.translate(
                offset: Offset(dxAnimation.value, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      gradient: !state.isDarkMode
                          ? const LinearGradient(
                              colors: [Color(0xff63608f), Color(0xff49528b)],
                              stops: [.1, .5],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
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
                                        child: const Row(
                                          children: [
                                            Text(
                                              'Lambare',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Despejado',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
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
                                                color: Colors.white70,
                                                fontSize: 15),
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
                          margin:
                              EdgeInsets.symmetric(horizontal: padding * .5),
                          height: 150,
                          decoration: BoxDecoration(
                              color: !state.isDarkMode
                                  ? const Color(0xff3c4274)
                                  : const Color(0xff171717),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
