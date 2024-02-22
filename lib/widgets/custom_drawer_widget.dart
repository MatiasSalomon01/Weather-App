import 'package:flutter/material.dart';
import 'package:weather_app/models/models.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.size,
    required this.end,
    required this.padding,
    required this.currentWeather,
    required this.isDarkMode,
  });

  final CurrentWeatherResponse currentWeather;
  final Size size;
  final double end;
  final double padding;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    bool isDay = currentWeather.current.is_day == 1;
    return SafeArea(
      child: Container(
        // margin: EdgeInsets.only(left: 10),
        height: size.height,
        width: end - 5,
        decoration: BoxDecoration(
          color: !isDarkMode
              ? isDay
                  ? const Color(0xff88bbfd)
                  : const Color(0xff63608f)
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
                Text(
                  currentWeather.location.name,
                  style: const TextStyle(
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
                Text(
                  '${currentWeather.current.temp_c}º',
                  style: const TextStyle(
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
                Text(
                  currentWeather.location.name,
                  style: const TextStyle(
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
                Text(
                  '${currentWeather.current.temp_c}º',
                  style: const TextStyle(
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
                  backgroundColor: MaterialStateProperty.all(Colors.white12),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0))),
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
    );
  }
}
