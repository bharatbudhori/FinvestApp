import 'package:finvest_task/Screens/HomeScreen/home_bloc.dart';
import 'package:finvest_task/Screens/HomeScreen/home_state.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:finvest_task/Utils/dummy_data.dart';
import 'package:finvest_task/Widgets/balance_chart.dart';
import 'package:finvest_task/Widgets/section_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FinvestColors.bgColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_outlined,
          size: 16,
        ),
        centerTitle: false,
        title: const Text('Credit Card',
            style:
                TextStyle(color: FinvestColors.primaryTextColor, fontSize: 18)),
        surfaceTintColor: FinvestColors.secondaryBgColor,
        backgroundColor: FinvestColors.secondaryBgColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: Image.network(
                "https://i.ibb.co/d5ffpHt/output-onlinegiftools.gif",
                width: 120,
                height: 120,
              ),
            );
          } else if (state.hasData) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BalanceDueChart(),
                  SectionCardWidget(data: creditCardDummyData),
                  const SizedBox(height: 14),
                  SectionCardWidget(data: topcategoriesDummyData),
                  const SizedBox(height: 14),
                  SectionCardWidget(data: recentTransactionsDummyData),
                  const SizedBox(height: 20)
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
