import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class RemoveFilter extends TransactionEvent {
  final String filterType;

  RemoveFilter({required this.filterType});

  @override
  List<Object> get props => [filterType];
}

class ApplyFilter extends TransactionEvent {
  final String dateRange;
  final String status;
  final String category;
  final String transactionType;

  ApplyFilter({
    required this.dateRange,
    required this.status,
    required this.category,
    required this.transactionType,
  });

  @override
  List<Object> get props => [dateRange, status, category, transactionType];
}

class LoadMoreTransactions extends TransactionEvent {}
