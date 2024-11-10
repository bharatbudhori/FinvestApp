import 'package:finvest_task/Models/section_item.dart';
import 'package:finvest_task/Models/transaction_item.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:flutter/material.dart';

final creditCardDummyData = SectionItem(
  title: "Credit cards",
  transactions: [
    TransactionItem(
      title: "Wellsfargo Gold ",
      subtitle: "Asset •••6372 ",
      amount: "-\$23,450.24",
      imageUrl: "https://i.ibb.co/h2t8Y7s/Banks.png",
      category: "Food & Dining",
      status: "Pending",
    ),
    TransactionItem(
      title: "City Platinum",
      subtitle: "Asset •••6008",
      amount: "-\$12,000.32",
      imageUrl: "https://i.ibb.co/Q8vrNqG/Banks-1.png",
      category: "Shopping",
      status: "Completed",
    ),
  ],
  footer: FooterData(
    text: "ADD ACCOUNT",
    leadingIcon: const Icon(
      Icons.add,
      size: 16,
      color: FinvestColors.primaryColor,
    ),
  ),
);

final topcategoriesDummyData = SectionItem(
  title: "Top categories",
  transactions: [
    TransactionItem(
      title: "Foods & dining",
      subtitle: "90% of spends",
      amount: "-\$5000.45",
      imageUrl: "https://i.ibb.co/GkG31mx/categories.png",
      category: "Food & Dining",
      status: "Pending",
    ),
    TransactionItem(
      title: "Health & wellness",
      subtitle: "10% of spends",
      amount: "-\$3500.12",
      imageUrl: "https://i.ibb.co/JmPfLdw/Frame-1116606544.png",
      category: "Shopping",
      status: "Completed",
    ),
    TransactionItem(
      title: "Apps & software",
      subtitle: "40% of spends",
      amount: "-\$825.90",
      imageUrl: "https://i.ibb.co/kSg8C45/Group-1116605248.png",
      category: "Food & Dining",
      status: "Completed",
    ),
  ],
  footer: FooterData(
    text: "SEE ALL CATEGORIES",
    trailingIcon: const Icon(
      Icons.chevron_right_rounded,
      size: 16,
      color: FinvestColors.primaryColor,
    ),
  ),
);

final recentTransactionsDummyData = SectionItem(
  title: "Recent transactions",
  transactions: [
    TransactionItem(
      title: "Uber",
      subtitle: "22 Jun 24, 4:25pm • Pending",
      amount: "-\$82.00",
      imageUrl: "https://i.ibb.co/svsBYVM/Component-8-1.png",
      category: "Shopping",
      status: "Pending",
    ),
    TransactionItem(
      title: "Mc Donalds",
      subtitle: "22 Jun 24, 4:25pm ",
      amount: "-\$82.00",
      imageUrl: "https://i.ibb.co/94Vq6Fy/Component-8.png",
      category: "Food & Dining",
      status: "Completed",
    ),
    TransactionItem(
      title: "Ikea",
      subtitle: "22 Jun 24, 4:25pm",
      amount: "-\$182.00",
      imageUrl: "https://i.ibb.co/dbLshFV/Component-8-1.png",
      category: "Food & Dining",
      status: "Completed",
    ),
    TransactionItem(
      title: "JBL technologies",
      subtitle: "22 Jun 24, 4:25pm • Pending",
      amount: "-\$82.00",
      imageUrl: "https://i.ibb.co/BVPg51N/Component-8-2.png",
      category: "Shopping",
      status: "Pending",
    )
  ],
  footer: FooterData(
    text: "SEE ALL TRANSACTIONS",
    trailingIcon: const Icon(
      Icons.chevron_right_rounded,
      size: 16,
      color: FinvestColors.primaryColor,
    ),
  ),
);
