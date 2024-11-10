import 'package:finvest_task/Utils/colors.dart';
import 'package:flutter/material.dart';

class AmountDisplayWidget extends StatelessWidget {
  final String amount;
  final double fontSize;

  const AmountDisplayWidget(
      {super.key, required this.amount, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    // Split the amount into the main number and decimal parts
    List<String> parts = amount.split('.');

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the top
      children: [
        Text(
          parts[0], // Main number
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: FinvestColors.primaryTextColor,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          '.${parts.length > 1 ? parts[1] : '00'}', // Decimal part
          style: TextStyle(
            fontSize:
                fontSize * 0.6, // Set decimal font size to a smaller proportion
            fontWeight: FontWeight.w500,
            color: FinvestColors.primaryTextColor,
          ),
        ),
      ],
    );
  }
}
