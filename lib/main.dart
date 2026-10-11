import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark, fontFamily: '.SF Pro Display'),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with SingleTickerProviderStateMixin {
  late final AnimationController _sky = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();

  static const _hours = [
    ('Now', Icons.wb_sunny_rounded, 72), ('1PM', Icons.wb_sunny_rounded, 74), ('2PM', Icons.wb_cloudy_rounded, 75),
    ('3PM', Icons.wb_cloudy_rounded, 73), ('4PM', Icons.wb_sunny_rounded, 71), ('5PM', Icons.nights_stay_rounded, 68),
  ];
  static const _days = [
    ('Today', Icons.wb_sunny_rounded, 61, 75), ('Mon', Icons.wb_cloudy_rounded, 59, 70), ('Tue', Icons.grain_rounded, 55, 64),
    ('Wed', Icons.wb_sunny_rounded, 58, 72), ('Thu', Icons.wb_sunny_rounded, 62, 78),
  ];

  @override
  void dispose() {
    _sky.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _sky,
        builder: (context, child) {
          final t = _sky.value * 2 * math.pi;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.6 + 0.2 * math.sin(t), -1),
                end: Alignment(0.6, 1),
                colors: const [Color(0xFF3A7BFF), Color(0xFF5B5BE6), Color(0xFF241B5E)],
              ),
            ),
            child: Stack(children: [
              Positioned(
                right: -60 + 10 * math.sin(t),
                top: 60 + 8 * math.cos(t),
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [
                    const Color(0xFFFFE08A).withOpacity(0.9),
                    const Color(0xFFFFB347).withOpacity(0.25),
                    Colors.transparent,
                  ])),
                ),
              ),
              child!,
            ]),
          );
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            children: [
              const SizedBox(height: 30),
              const Center(child: Text('San Francisco', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500))),
              const Center(
                child: Text('72°', style: TextStyle(fontSize: 112, fontWeight: FontWeight.w200, height: 1.05)),
              ),
              const Center(child: Text('Mostly Sunny', style: TextStyle(fontSize: 22, color: Colors.white70))),
              const Center(child: Text('H:75°  L:61°', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
              const SizedBox(height: 34),
              _glass(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Sunny all afternoon. Light breeze from the west.', style: TextStyle(fontSize: 15, color: Colors.white)),
                const Divider(color: Colors.white24, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final h in _hours)
                      Column(children: [
                        Text(h.$1, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Icon(h.$2, color: h.$2 == Icons.wb_sunny_rounded ? const Color(0xFFFFD25A) : Colors.white, size: 26),
                        const SizedBox(height: 10),
                        Text('${h.$3}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      ]),
                  ],
                ),
              ])),
              const SizedBox(height: 14),
              _glass(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('5-DAY FORECAST', style: TextStyle(fontSize: 12, color: Colors.white60, letterSpacing: 1)),
                const Divider(color: Colors.white24, height: 20),
                for (final d in _days)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      SizedBox(width: 62, child: Text(d.$1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
                      Icon(d.$2, color: d.$2 == Icons.wb_sunny_rounded ? const Color(0xFFFFD25A) : Colors.white, size: 24),
                      const SizedBox(width: 18),
                      Text('${d.$3}°', style: const TextStyle(fontSize: 18, color: Colors.white60)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: const LinearGradient(colors: [Color(0xFF7FE0FF), Color(0xFFFFD25A), Color(0xFFFF9A4D)]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('${d.$4}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    ]),
                  ),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glass(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
        ),
        child: child,
      );
}
