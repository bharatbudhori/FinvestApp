import 'package:finvest_task/Models/section_item.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_screen.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:finvest_task/Utils/extensions.dart';
import 'package:finvest_task/Widgets/divider_widget.dart';
import 'package:finvest_task/Widgets/transaction_widget.dart';
import 'package:flutter/material.dart';

class SectionCardWidget extends StatelessWidget {
  final SectionItem data;
  const SectionCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: FinvestColors.secondaryBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: Colors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.title != null) ...[
            Text(
              data.title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: FinvestColors.primaryTextColor,
              ),
            ),
            const DividerWidget().padding(
                data: PaddingData(left: 0, right: 0, bottom: 14, top: 14))
          ],
          ...data.transactions.asMap().entries.map((entry) {
            int index = entry.key;
            var transactionData = entry.value;

            return Column(
              children: [
                // Optional: display the index
                if (index > 0)
                  const DividerWidget().padding(
                      data:
                          PaddingData(left: 0, right: 0, bottom: 14, top: 14)),
                TransactionWidget(data: transactionData),
              ],
            );
          }),
          if (data.footer != null) ...[
            const DividerWidget().padding(
                data: PaddingData(left: 0, right: 0, bottom: 16, top: 14)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TransactionListScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data.footer!.leadingIcon ?? const SizedBox.shrink(),
                  const SizedBox(width: 4),
                  Text(
                    data.footer!.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FinvestColors.primaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  data.footer!.trailingIcon ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
