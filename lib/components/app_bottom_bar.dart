import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/view/dashboard/home/home_screen.dart';
import 'package:atfb/view/dashboard/profile/profile.dart';
import 'package:atfb/view/dashboard/weekly_plan/weekly_plan.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  AppBottomBar({super.key, required this.selectedIndex});
  int selectedIndex = 1;
  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  // Default: Home

  final List<Map<String, dynamic>> _items = [
    {"icon": Icons.calendar_month, "label": "Week Plan"},
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.person, "label": "Account"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: openPage(widget.selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom bar background
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0DC), // light peach
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Week Plan (Left)
                  GestureDetector(
                    onTap: () => setState(() => widget.selectedIndex = 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            color: widget.selectedIndex == 0
                                ? Colors.orange
                                : Colors.black),
                        const SizedBox(height: 4),
                        Text(
                          "Week Plan",
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.selectedIndex == 0
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 80), // space for Home circle

                  // Account (Right)
                  GestureDetector(
                    onTap: () => setState(() => widget.selectedIndex = 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                            color: widget.selectedIndex == 2
                                ? Colors.orange
                                : Colors.black),
                        const SizedBox(height: 4),
                        Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.selectedIndex == 2
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Floating Home Button (Always Center)
            Positioned.fill(
              top: -20,
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () => setState(() => widget.selectedIndex = 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                          border: Border.all(
                            color: Colors.orange.shade200,
                            width: 4,
                          ),
                        ),
                        child: const Icon(Icons.home, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 13,
                          color: widget.selectedIndex == 1
                              ? Colors.orange
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

  openPage(int index) {
    switch (index) {
      case 0:
        return WeeklyPlan();
      case 1:
        return HomeScreen();
      case 2:
        return Profile();
    }
  }
}
