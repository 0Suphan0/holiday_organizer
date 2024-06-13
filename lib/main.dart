import 'package:flutter/material.dart';
import 'Screens/holiday_organizer_screen.dart';


void main() {
  runApp(const HolidayOrganizer());
}

class HolidayOrganizer extends StatelessWidget {
  const HolidayOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HolidayOrganizerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

