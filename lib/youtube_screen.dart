import 'package:flutter/material.dart';
import 'package:navigation_rail/responsive/desktop_body.dart';
import 'package:navigation_rail/responsive/mobile_body.dart';
import 'package:navigation_rail/responsive/responsive_layout.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ResponsiveLayout(
          mobileBody: MobileBody(), desktopBody: DesktopBody()),
    );
  }
}
