import 'package:finvest_task/Models/section_item.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_bloc.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_event.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_state.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:finvest_task/Utils/extensions.dart';
import 'package:finvest_task/Widgets/divider_widget.dart';
import 'package:finvest_task/Widgets/section_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Listen to scroll events
    scrollController.addListener(() {
      // if (scrollController.position.pixels >=
      //         scrollController.position.maxScrollExtent - 200 &&
      //     !context.read<TransactionBloc>().isLoadingMore) {
      //   context.read<TransactionBloc>().add(LoadMoreTransactions());
      // }
    });

    return Scaffold(
      backgroundColor: FinvestColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: FinvestColors.bgColor,
        backgroundColor: FinvestColors.bgColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          bool isLoadingMore = context.read<TransactionBloc>().isLoadingMore;
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded ||
              state is TransactionFiltered) {
            final transactions = state is TransactionLoaded
                ? state.transactions
                : (state as TransactionFiltered).filteredTransactions;

            final activeFilters =
                state is TransactionFiltered ? state.activeFilters : {};

            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(
                        fontSize: 32,
                        color: FinvestColors.primaryTextColor,
                        fontWeight: FontWeight.w500),
                  ).padding(
                      data:
                          PaddingData(left: 12, right: 12, bottom: 16, top: 0)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showFilterBottomSheet(context, activeFilters);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                color: FinvestColors.secondaryBgColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: activeFilters.isEmpty
                                        ? Colors.white
                                        : FinvestColors.primaryTextColor)),
                            child: Row(
                              children: [
                                if (activeFilters.isNotEmpty)
                                  CircleAvatar(
                                    radius: 7,
                                    backgroundColor: FinvestColors.primaryColor,
                                    child: Text(
                                      activeFilters.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 9, color: Colors.white),
                                    ),
                                  ),
                                const SizedBox(width: 4),
                                const Text(
                                  "Filters",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: FinvestColors.primaryTextColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.tune_outlined,
                                  size: 18,
                                  color: FinvestColors.primaryTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...activeFilters.entries.map((filter) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              // visualDensity: VisualDensity.compact,
                              side: const BorderSide(
                                  color: FinvestColors.primaryTextColor),
                              backgroundColor: FinvestColors.secondaryBgColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              label: Text(
                                filter.value,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: FinvestColors.primaryTextColor),
                              ),
                              deleteIcon: const Icon(
                                Icons.clear,
                                size: 18,
                              ),
                              onDeleted: () {
                                context
                                    .read<TransactionBloc>()
                                    .add(RemoveFilter(filterType: filter.key));
                              },
                            ),
                          );
                        }),
                      ],
                    ).padding(
                        data:
                            PaddingData(left: 8, right: 0, bottom: 16, top: 0)),
                  ),
                  if (transactions.isNotEmpty)
                    SectionCardWidget(
                        data: SectionItem(transactions: transactions)),
                  if (transactions.isEmpty) ...[
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.network(
                        "https://i.ibb.co/gmHJDZW/811214395912-Data-Analytics.gif",
                        width: 120,
                        height: 120,
                      ),
                    ]).padding(
                        data:
                            PaddingData(left: 0, right: 0, bottom: 0, top: 54)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No transaction found!",
                          style: TextStyle(
                              fontSize: 18,
                              color: FinvestColors.primaryTextColor,
                              fontWeight: FontWeight.w500),
                        ).padding(
                            data: PaddingData(
                                left: 12, right: 12, bottom: 0, top: 16)),
                      ],
                    ),
                    if (isLoadingMore)
                      Positioned(
                        bottom: 16,
                        left: MediaQuery.of(context).size.width / 2 - 15,
                        child: const CircularProgressIndicator(),
                      ),
                  ]
                ],
              ).padding(
                  data: PaddingData(left: 0, right: 0, bottom: 32, top: 0)),
            );
          } else {
            return const Center(child: Text('No transactions found.'));
          }
        },
      ),
    );
  }
}

void showFilterBottomSheet(
    BuildContext context, Map<dynamic, dynamic> activeFilters) {
  // Set initial selected values from active filters or use defaults
  String selectedDateRange = activeFilters['dateRange'] ?? 'All time';
  String selectedStatus = activeFilters['status'] ?? 'All';
  String selectedCategory = activeFilters['category'] ?? 'All';
  String selectedTransactionType = activeFilters['transactionType'] ?? 'All';

  showModalBottomSheet(
    context: context,
    backgroundColor: FinvestColors.secondaryBgColor,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filters',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: FinvestColors.primaryTextColor)),
                  const DividerWidget().padding(
                    data: PaddingData(left: 0, right: 0, bottom: 16, top: 16),
                  ),
                  const Text(
                    'Date range',
                    style: TextStyle(
                      fontSize: 20,
                      color: FinvestColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      'All time',
                      'Current month',
                      'Last month',
                      'This year'
                    ]
                        .map((range) => ChoiceChip(
                              visualDensity: VisualDensity.compact,
                              label: Text(range),
                              showCheckmark: false,
                              selectedColor: FinvestColors.bgColor,
                              iconTheme: null,
                              color:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return FinvestColors.bgColor;
                                }
                                return selectedDateRange == range
                                    ? FinvestColors.bgColor
                                    : FinvestColors.secondaryBgColor;
                              }),
                              side: BorderSide(
                                width: 1,
                                color: selectedDateRange == range
                                    ? FinvestColors.primaryTextColor
                                    : const Color(0xffDFE8F5),
                              ),
                              selected: selectedDateRange == range,
                              onSelected: (selected) {
                                setState(() {
                                  selectedDateRange = range;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const DividerWidget().padding(
                      data:
                          PaddingData(left: 0, right: 0, bottom: 20, top: 20)),
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 20,
                      color: FinvestColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    children: ['All', 'Completed', 'Pending']
                        .map((status) => ChoiceChip(
                              visualDensity: VisualDensity.compact,
                              label: Text(status),
                              showCheckmark: false,
                              selectedColor: FinvestColors.bgColor,
                              iconTheme: null,
                              color:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return FinvestColors.bgColor;
                                }
                                return selectedStatus == status
                                    ? FinvestColors.bgColor
                                    : FinvestColors.secondaryBgColor;
                              }),
                              side: BorderSide(
                                width: 1,
                                color: selectedStatus == status
                                    ? FinvestColors.primaryTextColor
                                    : const Color(0xffDFE8F5),
                              ),
                              selected: selectedStatus == status,
                              onSelected: (selected) {
                                setState(() {
                                  selectedStatus = status;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const DividerWidget().padding(
                      data:
                          PaddingData(left: 0, right: 0, bottom: 20, top: 20)),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      color: FinvestColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    children: ['All', 'Food & Dining', 'Shopping']
                        .map((category) => ChoiceChip(
                              visualDensity: VisualDensity.compact,
                              label: Text(category),
                              showCheckmark: false,
                              selectedColor: FinvestColors.bgColor,
                              iconTheme: null,
                              color:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return FinvestColors.bgColor;
                                }
                                return selectedCategory == category
                                    ? FinvestColors.bgColor
                                    : FinvestColors.secondaryBgColor;
                              }),
                              side: BorderSide(
                                width: 1,
                                color: selectedCategory == category
                                    ? FinvestColors.primaryTextColor
                                    : const Color(0xffDFE8F5),
                              ),
                              selected: selectedCategory == category,
                              onSelected: (selected) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const DividerWidget().padding(
                      data:
                          PaddingData(left: 0, right: 0, bottom: 20, top: 20)),
                  const Text(
                    'Transaction type',
                    style: TextStyle(
                      fontSize: 20,
                      color: FinvestColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    children: ['All', 'Deposit', 'Withdrawal']
                        .map((type) => ChoiceChip(
                              visualDensity: VisualDensity.compact,
                              label: Text(type),
                              showCheckmark: false,
                              iconTheme: null,
                              color:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return FinvestColors.bgColor;
                                }
                                return selectedTransactionType == type
                                    ? FinvestColors.bgColor
                                    : FinvestColors.secondaryBgColor;
                              }),
                              side: BorderSide(
                                width: 1,
                                color: selectedTransactionType == type
                                    ? FinvestColors.primaryTextColor
                                    : const Color(0xffDFE8F5),
                              ),
                              selected: selectedTransactionType == type,
                              onSelected: (selected) {
                                setState(() {
                                  selectedTransactionType = type;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<TransactionBloc>().add(
                                  ApplyFilter(
                                    dateRange: "All time",
                                    status: "All",
                                    category: "All",
                                    transactionType: "All",
                                  ),
                                );
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              color: FinvestColors.primaryTextColor,
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            "Clear all",
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<TransactionBloc>().add(
                                  ApplyFilter(
                                    dateRange: selectedDateRange,
                                    status: selectedStatus,
                                    category: selectedCategory,
                                    transactionType: selectedTransactionType,
                                  ),
                                );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: FinvestColors.primaryTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
