import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/widget/custom_app_bar.dart';
import 'package:smartOne/widget/double_bottom_button.dart';
import 'package:smartOne/widget/full_page_content_widget.dart';
import 'package:smartOne/widget/tab_widget.dart';

import 'app_manager/color_manager.dart';
import 'bloc/stock_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Market App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StockMarketScreen(),
      ),
    );
  }
}

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({super.key});

  @override
  State<StockMarketScreen> createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        context,
        bottom: TabBar(
          dividerColor: Colors.grey,
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          onTap: (data) => setState(() {}),
          tabs: List.generate(
            3,
            (index) => TabWidget(
              isSelected: index == _tabController.index,
            ),
          ),
          indicatorColor: AppColors.color89242a,
          labelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FullContentPageWidget(),
          FullContentPageWidget(),
          FullContentPageWidget(),
        ],
      ),
      bottomNavigationBar: const BottomActionButton(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
