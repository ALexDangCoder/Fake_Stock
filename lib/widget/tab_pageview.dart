import 'package:flutter/material.dart';

class TabPageView extends StatefulWidget {
  const TabPageView({super.key});

  @override
  TabPageViewState createState() => TabPageViewState();
}

class TabPageViewState extends State<TabPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cổ phiếu'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: '762663',
              icon: Icon(Icons.circle, size: 10),
            ),
            Tab(
              text: '762663',
              icon: Icon(Icons.circle, size: 10),
            ),
            Tab(
              text: '762663',
              icon: Icon(Icons.circle, size: 10),
            ),
          ],
          indicatorColor: Colors.red,
          labelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: Text('Page 1')),
          Center(child: Text('Page 2')),
          Center(child: Text('Page 3')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
