import 'package:flutter/material.dart';
import 'package:poetryapp/view/components/search_result.dart';

typedef SearchItemCall = void Function(String item);

class SearchBarDelegate extends SearchDelegate<String> {

  List<String> items = [
    '李白', '苏轼','李清照','杜甫','王维' ,'写景', '咏物', '写人', '春天', '夏天', '秋天', '冬天'
    ,'写花', '写雨','写雪','写风','田园','边塞','地名','节日','怀古','抒情',
    '爱国','离别','思乡','思念','爱情','励志', '哲理', '闺怨', '悼亡', '婉约',
    '豪放', '战争','惜时'
  ];

  @override
  String get searchFieldLabel => '搜索';

  @override
  List<Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, "");
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面
    return SearchResult(query: query);
  }

  @override
  void showResults(BuildContext context) {
//    Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => SearchResult(query: query))
//    );
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //点击了搜索窗显示的页面
//    return SearchContentView();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '大家都在搜',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
//          SearchItemView(),
          Container(
            child: Wrap(
              spacing: 10,
              // runSpacing: 0,
              children: items.map((item) {
//          return SearchItem(title: item);
                return Container(
                  child: InkWell(
                    child: Chip(
                      label: Text(item),
                      shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white,
                      elevation: 0.8,
                      shadowColor: Colors.grey,
                    ),
                    onTap: () {
                      print(item);
                      query = item;
                      showResults(context);

                    },
                  ),
                );
              }).toList(),
            ),
          )

        ],
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }
}

