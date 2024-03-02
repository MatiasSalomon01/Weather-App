import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/widgets/widgets.dart';

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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        bool isDay = DateTime.now().hour < 18;
        if (state is WeatherResult) {
          isDay = state.currentWeather.current.is_day == 1;
        }

        return Consumer<ThemeProvider>(
          builder: (context, value, child) => Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: !value.isDarkMode
                ? isDay
                    ? const Color(0xff88bbfd)
                    : const Color(0xff63608f)
                : null,
            //const Color(0xff61a4f2)
            body: state is WeatherLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          'assets/loading.json',
                          height: 50,
                        ),
                        const Text(
                          'Cargando...',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                  )
                : state is WeatherResult
                    ? RefreshIndicator(
                        onRefresh: () async => context
                            .read<WeatherBloc>()
                            .add(GetCurrentWeatherEvent()),
                        child: AnnotatedRegion<SystemUiOverlayStyle>(
                          value: const SystemUiOverlayStyle(
                              statusBarColor: Colors.transparent),
                          child: Stack(
                            children: [
                              Transform.translate(
                                offset: Offset(dxAnimationDrawer.value, 0),
                                child: CustomDrawer(
                                  size: size,
                                  end: end,
                                  padding: padding,
                                  currentWeather: state.currentWeather,
                                  isDarkMode: value.isDarkMode,
                                ),
                              ),
                              SafeArea(
                                child: Transform.translate(
                                  offset: Offset(dxAnimation.value, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // borderRadius: const BorderRadius.only(
                                      //   topLeft: Radius.circular(20),
                                      //   bottomLeft: Radius.circular(20),
                                      // ),
                                      color: !value.isDarkMode
                                          ? isDay
                                              ? const Color(0xff88bbfd)
                                              : const Color(0xff63608f)
                                          : null,
                                      gradient: !value.isDarkMode && !isDay
                                          ? const LinearGradient(
                                              colors: [
                                                Color(0xff63608f),
                                                Color(0xff49528b)
                                              ],
                                              stops: [.1, .5],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )
                                          : null,
                                    ),
                                    child: CustomAppBarWithContent(
                                      scrollController: scrollController,
                                      padding: padding,
                                      animationController: animationController,
                                      opacity: opacity,
                                      currentWeather: state.currentWeather,
                                      isDarkMode: value.isDarkMode,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Error',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}
