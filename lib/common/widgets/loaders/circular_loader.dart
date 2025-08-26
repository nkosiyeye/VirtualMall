import 'package:flutter/material.dart';

class TCircularLoader extends StatelessWidget{
  const TCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator()
        ],
      ),
    );
  }

}