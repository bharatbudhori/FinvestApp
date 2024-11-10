import 'package:finvest_task/Models/transaction_item.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:finvest_task/Widgets/amount_display_widget.dart';
import 'package:flutter/cupertino.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionItem data;
  const TransactionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          data.imageUrl,
          height: 48,
          width: 48,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: FinvestColors.primaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                data.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: FinvestColors.secondaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        AmountDisplayWidget(amount: data.amount, fontSize: 16)
      ],
    );
  }
}
