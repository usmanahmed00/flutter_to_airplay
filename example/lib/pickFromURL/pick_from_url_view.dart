import 'package:flutter/material.dart';
import 'package:flutter_to_airplay/flutter_to_airplay.dart';

class PickFromURLView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter 2 Airplay'),
          leading: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            AirPlayRoutePickerView(
              tintColor: Colors.white,
              activeTintColor: Colors.white,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: FlutterAVPlayerView(
              urlString:
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              autoLoop: true,
            ),
          ),
        ),
      ),
    );
  }
}
