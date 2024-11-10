import 'package:equatable/equatable.dart';
import 'package:finvest_task/Models/transaction_item.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object> get props => [];
}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionItem> transactions;

  TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionFiltered extends TransactionState {
  final List<TransactionItem> filteredTransactions;
  final Map<String, String> activeFilters;

  TransactionFiltered(
      List<TransactionItem> filteredTransactions, this.activeFilters)
      : filteredTransactions = List.from(filteredTransactions);

  @override
  List<Object> get props => [filteredTransactions, activeFilters];
}
