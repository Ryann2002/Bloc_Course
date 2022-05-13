import 'dart:async';

import 'package:bloc_course/dialogs/loading_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  //singleton pattern
  LoadingScreen._sharedInstance();
  static late final LoadingScreen _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}


//! video 3:58:52 / 11:29:38
//! link https://www.youtube.com/watch?v=Mn254cnduOY