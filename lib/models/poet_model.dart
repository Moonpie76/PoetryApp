import 'package:flutter/cupertino.dart';

const avatarUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdl.ppt123.net%2Fpptbj%2F51%2F20181115%2Fgueu4ktemmw.jpg&refer=http%3A%2F%2Fdl.ppt123.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626003601&t=b4cea5212b705db109466fcd9dd77152';
/// 列表模型
class PoetList {
  List<PoetItem> list;

  PoetList(this.list);

  factory PoetList.fromJson(List<dynamic> list) {
    return PoetList(
      list.map((item) => PoetItem.fromJson(item)).toList(),
    );
  }
}
/// 列表项/详情模型
class PoetItem {
  final int poet_id;
  final String image;
  final String name;
  final String dynasty;
  final String desc;

  PoetItem({
    this.poet_id = 0,
    this.image = avatarUrl,
    this.name = '',
    this.dynasty = '',
    this.desc = ''
  });

  factory PoetItem.fromJson(dynamic item) {
    return PoetItem(
      poet_id: item.containsKey("poet_id")? item['poet_id'] : item['Id'],
      image: item.containsKey("image")? item['image'] : avatarUrl,
      name: item.containsKey("name")? item['name'] : '佚名',
      dynasty: item.containsKey("dynasty")? item['dynasty'] : '',
      desc: item.containsKey("desc")? item['desc'] : '暂无描述',
    );
  }
}