import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  final String URL;

  const VideoPlayer({Key key, this.URL}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState(URL);
}

class _VideoPlayerState extends State<VideoPlayer> {
  final String url;

  _VideoPlayerState(this.url);
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WebView(
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://gvid') == false) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            } else {
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            }
          },
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
