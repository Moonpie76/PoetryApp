import 'package:flutter/material.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/view/root_pages/home_page.dart';
import 'package:poetryapp/view/root_pages/books_page.dart';
import 'package:poetryapp/view/root_pages/me_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

const bottomNames = {'home': '每日一读', 'books': '万象诗书', 'me': '温故知新'};

class _RootPageState extends State<RootPage> {
  //当前选中页面索引
  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _bottomNavBar = [];
  //页面集合
  late final List<Widget> _pages;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _pages = [
      HomePage(),
      BooksPage(),
      MePage(),
    ];
    bottomNames.forEach((key, value) {
      _bottomNavBar.add(_bottomNavBarItem(key, value));
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  void _onTabClick(int index) {
    setState(() {
      _controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _pages[index];
        },
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBar,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
          fixedColor: Color(0xFF415E89)
      ),
    );
  }
}

BottomNavigationBarItem _bottomNavBarItem(String key, String value) {
  return BottomNavigationBarItem(
      icon: Image.asset(
        'images/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'images/${key}_activate.png',
        width: 24,
        height: 24,
      ),
      label: value,
      tooltip: '');
}
