import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3A3F54),
      body: Center(
        child: SpinKitCubeGrid(
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
