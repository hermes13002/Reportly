import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';

/// animated splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    // navigate after animation
    Timer(const Duration(milliseconds: 10000), () {
      Get.off(() => const DashboardScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // using specific colors from design until theme is fully propagated
    const bgDark = Color(0xFF131022);
    const primary = Color(0xFF8B5CF6);

    return Scaffold(
      backgroundColor: bgDark,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // logo/icon container
                // Transform.scale(
                //   scale: _scaleAnimation.value,
                //   child: Opacity(
                //     opacity: _fadeAnimation.value,
                //     child: Container(
                //       width: 190,
                //       height: 190,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(24),
                //         boxShadow: [
                //           BoxShadow(
                //             color: const Color.fromARGB(
                //               255,
                //               247,
                //               246,
                //               250,
                //             ).withOpacity(0.3),
                //             blurRadius: 30,
                //             offset: const Offset(0, 10),
                //           ),
                //         ],
                //       ),
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(24),
                //         child: Image.asset(
                //           'assets/images/app-logo.png',
                //           // fit: BoxFit.contain,
                //           width: 170,
                //           height: 170,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Image.asset(
                          'assets/images/app-logo.png',
                          // fit: BoxFit.contain,
                          width: 170,
                          height: 170,
                        ),
                // const SizedBox(height: 32),

                // // app name
                // Opacity(
                //   opacity: _fadeAnimation.value,
                //   child: const Text(
                //     'Reportly',
                //     style: TextStyle(
                //       fontSize: 40,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 16),

                // tagline with dividers
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 1,
                        color: const Color(0xFF4C1D95),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'CODE TO REPORT',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 1,
                        color: const Color(0xFF4C1D95),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // loading indicator
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: 150,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2A42),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 50, // animated in real app
                        height: 4,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Loading workspace...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            );
          },
        ),
      ),
    );
  }
}
