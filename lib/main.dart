import 'package:finvest_task/Screens/AccountScreen/account_screen.dart';
import 'package:finvest_task/Screens/HomeScreen/home_bloc.dart';
import 'package:finvest_task/Screens/HomeScreen/home_event.dart';
import 'package:finvest_task/Screens/InvestScreen/invest_screen.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_bloc.dart';
import 'package:finvest_task/Screens/TransactionScreen/transaction_event.dart';
import 'package:finvest_task/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finvest_task/Screens/HomeScreen/home_screen.dart';
import 'package:finvest_task/Screens/DiscoverScreen/discover_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()
            ..add(
                LoadDataEvent()), // Initializing HomeBloc and triggering data load
        ),
        BlocProvider(
            create: (context) => TransactionBloc()..add(LoadTransactions())
            // Initializing HomeBloc and triggering data load
            ),
      ],
      child: const MaterialApp(
        title: 'Credit Card Dashboard',
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const InvestScreen(),
    const DiscoverScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: FinvestColors.primaryColor,
        unselectedItemColor: FinvestColors.primaryTextColor,
        backgroundColor: FinvestColors.secondaryBgColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? FinvestColors.primaryColor
                    : FinvestColors.primaryTextColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart,
                color: _selectedIndex == 1
                    ? FinvestColors.primaryColor
                    : FinvestColors.primaryTextColor),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore,
                color: _selectedIndex == 2
                    ? FinvestColors.primaryColor
                    : FinvestColors.primaryTextColor),
            label: 'Discover',
          ),
          const BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.ibb.co/QcdBNWB/Ellipse-12745.png'), // Placeholder for user profile image
              radius: 12,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
