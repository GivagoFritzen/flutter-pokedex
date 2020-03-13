import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width / 3;
    var height = screenSize.height / 3;

    return Container(
      child: Center(
        child: SizedBox(
          child: Image(
            image: AssetImage('assets/loading/pokemon-egg.gif'),
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }
}
