import 'package:flutter/material.dart';

class SystemScreen extends StatefulWidget {
  @override
  State<SystemScreen> createState() => SystemScreenState();
}

class SystemScreenState extends State<SystemScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> list = ["体系", "导航"];
  late TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              indicatorColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 16),
              unselectedLabelStyle: const TextStyle(fontSize: 16),
              controller: tabController,
              isScrollable: false,
              tabs: list.map((item) => Tab(text: item,)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                Center(
                  child: Text(
                    "体系",
                  ),
                ),
                Center(
                  child: Text(
                    "导航",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}