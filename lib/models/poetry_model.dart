import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:poetryapp/models/poet_model.dart';

/// 列表模型
class PoetryList {
  List<PoetryItem> list;

  PoetryList(this.list);

  factory PoetryList.fromJson(List<dynamic> list) {
    return PoetryList(
      list.map((item) => PoetryItem.fromJson(item)).toList(),
    );
  }
}
/// 列表项/详情模型
class PoetryItem {
  final int Id;
  final String content;
  final String name;
  final String poet;
  final String about;
  final String shangxi;
  final String fanyi;
  final String dynasty;

  PoetryItem({
    this.Id = 0,
    this.name = '',
    this.about = '',
    this.content = '',
    this.fanyi = '',
    this.poet = '',
    this.shangxi = '',
    this.dynasty = '',
  });

  factory PoetryItem.fromJson(dynamic item) {
    return PoetryItem(
      Id: item['Id'],
      name: item.containsKey("name")? item['name'] : '',
      about: item.containsKey("about")? item['about'] : '',
      content: item.containsKey("content")? item['content'] : '',
      shangxi: item.containsKey("shangxi")? item['shangxi'] : '',
      fanyi: item.containsKey("fanyi")? item['fanyi'] : '',
      dynasty: item.containsKey("dynasty")? item['dynasty'] : '',
      poet: item['poet'] is String ? item['poet'] : PoetItem.fromJson(item['poet']).name
    );
  }



}
