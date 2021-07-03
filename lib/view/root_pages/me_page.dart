import 'package:flutter/material.dart';
import 'package:poetryapp/view/sub_pages/my_cards_page.dart';
import 'package:poetryapp/view/sub_pages/my_poetry_page.dart';


class MePage extends StatefulWidget {
  MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

const List<Tab> _tabs = [
  Tab(
    text: '我的摘录',
  ),
  Tab(
    text: '我的诗词',
  )
];

final List<Widget> _tabsContent = [
  MyCardsPage(),
  MyPoetryPage(),
];

class _MePageState extends State<MePage> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: TabBarView(
        children: _tabsContent,
        controller: _tabController,
      ),
    );
  }

}
