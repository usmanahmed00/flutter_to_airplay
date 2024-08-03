import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// This widget returns a UIView from swift with an AVPlayer inside,
/// it can be added as it is, or inside a Container to limit
/// and control its width and height.

class FlutterAVPlayerView extends StatelessWidget {
  const FlutterAVPlayerView({
    Key? key,
    this.urlString,
    this.filePath,
    this.autoLoop = false,
  })  : assert(urlString != null || filePath != null),
        super(key: key);

  /// URL string for the video file, if the file is to be played from the network.
  final String? urlString;

  /// Asset name/path for the video file that needs to be played.
  final String? filePath;
  final bool autoLoop;

  /// This function packs the available parameters to be sent to native code.
  /// It will check for the URL first, if it is available, then it will be used,
  /// otherwise filePath will be used.
  /// It is preferred that only one of urlString or filePath is used at a time,
  /// if both are provided, application will prioritise urlString.
  Map<String, dynamic> getCreateParams() {
    Map<String, dynamic> params = {
      'class': 'FlutterAVPlayerView',
    };

    params['url'] = urlString;
    params['file'] = filePath;
    params['autoLoop'] = autoLoop;

    return params;
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType:
          'flutter_avplayer_view', // This is the identifier that helps distinguish different views in the native code.
      creationParams:
          getCreateParams(), // parameters to load the video in native code.
      creationParamsCodec:
          StandardMessageCodec(), // messenger to decode message between flutter and native.
    );
  }
}
