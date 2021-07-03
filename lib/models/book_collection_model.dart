import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

const avatarUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdl.ppt123.net%2Fpptbj%2F51%2F20181115%2Fgueu4ktemmw.jpg&refer=http%3A%2F%2Fdl.ppt123.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626003601&t=b4cea5212b705db109466fcd9dd77152';
/// 列表模型
class BookCollectionList {
  List<BookCollectionItem> list;

  BookCollectionList(this.list);

  factory BookCollectionList.fromJson(List<dynamic> list) {
    return BookCollectionList(
      list.map((item) => BookCollectionItem.fromJson(item)).toList(),
    );
  }
}
/// 列表项/详情模型
class BookCollectionItem {
  final String picture;
  final String name;
  final String ju;
  final String collection;

  BookCollectionItem({
    this.picture = avatarUrl,
    this.name = '',
    this.ju = '',
    this.collection = ''
  });

  factory BookCollectionItem.fromJson(dynamic item) {
    return BookCollectionItem(
      picture: item.containsKey("picture")? item['picture'] : avatarUrl,
      name: item.containsKey("name")? item['name'] : '佚名',
      ju: item.containsKey("ju")? item['ju'] : '暂无描述',
      collection: item['collection']
    );
  }
}