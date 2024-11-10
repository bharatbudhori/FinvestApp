import 'package:finvest_task/Models/transaction_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final List<TransactionItem> _allTransactions = [
    // Dummy data
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
    ),
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
    ),
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
  ];

  List<TransactionItem> _displayedTransactions =
      []; // Transactions displayed so far
  Map<String, String> _activeFilters = {}; // Holds currently applied filters
  bool isLoadingMore = false; // Tracks if more data is being loaded

  TransactionBloc() : super(TransactionLoading()) {
    on<LoadTransactions>((event, emit) {
      _displayedTransactions =
          _allTransactions.take(10).toList(); // Initial batch
      emit(TransactionLoaded(_displayedTransactions));
    });

    on<ApplyFilter>((event, emit) {
      _activeFilters = {
        'dateRange': event.dateRange,
        'status': event.status,
        'category': event.category,
      };
      _filterTransactions(emit);
    });

    on<RemoveFilter>((event, emit) {
      if (event.filterType == 'dateRange') {
        _activeFilters[event.filterType] = "All time";
      }
      if (event.filterType == 'status') {
        _activeFilters[event.filterType] = "All";
      }
      if (event.filterType == 'category') {
        _activeFilters[event.filterType] = "All";
      }
      _filterTransactions(emit);
    });

    on<LoadMoreTransactions>((event, emit) async {
      if (!isLoadingMore) {
        // Check if already loading more data
        isLoadingMore = true; // Set to true to prevent multiple loads
        emit(TransactionLoading()); // Show loading overlay

        await Future.delayed(const Duration(seconds: 1)); // Simulate API delay

        // Fetch more data
        final newTransactions = List<TransactionItem>.from(_allTransactions);
        _displayedTransactions.addAll(newTransactions); // Append new data

        isLoadingMore = false; // Reset after loading
        emit(TransactionLoaded(_displayedTransactions));
      }
    });
  }

  void _filterTransactions(Emitter<TransactionState> emit) {
    List<TransactionItem> filteredTransactions =
        _displayedTransactions.where((transaction) {
      bool matchesDateRange = (_activeFilters['dateRange'] == 'All time' ||
              _activeFilters['dateRange'] == null) ||
          transaction.subtitle.contains(_activeFilters['dateRange'] ?? '');
      bool matchesStatus = (_activeFilters['status'] == 'All' ||
              _activeFilters['status'] == null) ||
          transaction.status == (_activeFilters['status'] ?? '');
      bool matchesCategory = (_activeFilters['category'] == 'All' ||
              _activeFilters['category'] == null) ||
          transaction.category == (_activeFilters['category'] ?? '');
      return matchesDateRange && matchesStatus && matchesCategory;
    }).toList();

    final updatedFilters = Map<String, String>.from(_activeFilters);
    if (updatedFilters['dateRange'] == "All time") {
      updatedFilters.remove('dateRange');
    }
    if (updatedFilters['status'] == "All") updatedFilters.remove('status');
    if (updatedFilters['category'] == "All") updatedFilters.remove('category');

    emit(TransactionFiltered(filteredTransactions, updatedFilters));
  }
}
