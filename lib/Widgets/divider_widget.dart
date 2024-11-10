import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffDFE8F5),
        border: BorderDirectional(
          bottom: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
