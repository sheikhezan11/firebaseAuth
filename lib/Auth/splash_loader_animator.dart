import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashLoaderAnimator extends StatelessWidget {
  const SplashLoaderAnimator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: LoadingAnimationWidget.discreteCircle(color: Colors.blueAccent, size: 60),

    );
  }
}
