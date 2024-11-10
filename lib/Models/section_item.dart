import 'package:finvest_task/Models/transaction_item.dart';
import 'package:flutter/material.dart';

class SectionItem {
  final String? title;
  final List<TransactionItem> transactions;
  final FooterData? footer;

  SectionItem({this.title, required this.transactions, this.footer});
}

class FooterData {
  final VoidCallback? callback;
  final String text;
  final Icon? leadingIcon;
  final Icon? trailingIcon;

  FooterData(
      {this.callback, required this.text, this.leadingIcon, this.trailingIcon});
}
