import 'package:flutter/material.dart';
import 'package:poetryapp/view/sub_pages/all_poetry_page.dart';
import 'package:poetryapp/view/sub_pages/authors_page.dart';
import 'package:poetryapp/view/sub_pages/collections_page.dart';
import 'package:poetryapp/view/sub_pages/search_page.dart';

class BooksPage extends StatefulWidget {
  BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

const List<Tab> _tabs = [
  Tab(text: '选集',),
  Tab(text: '全部',),
  Tab(text: '作者',),
];

final List<Widget> _tabsContent = [
  CollectionsPage(),
  AllPoetryPage(),
  AuthorsPage(),
];

class _BooksPageState extends State<BooksPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _tabs.length,
        vsync: this
    );
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
          controller: _tabController ,
        ),
        elevation: 1,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.search),
            onPressed: (){
              showSearch(context: context,delegate: SearchBarDelegate());
            }
          )
        ],
      ),
      body: TabBarView(
        children: _tabsContent,
        controller: _tabController,
      ),

    );
  }
}