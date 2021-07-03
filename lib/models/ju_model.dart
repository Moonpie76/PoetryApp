
/// 列表模型
class JuList {
  List<JuItem> list;

  JuList(this.list);

  factory JuList.fromJson(List<dynamic> list) {
    return JuList(
      list.map((item) => JuItem.fromJson(item)).toList(),
    );
  }
}
/// 列表项/详情模型
class JuItem {
  final int id;
  final String content;
  final String poetName;
  final int poetryId;

  JuItem({
    this.id = 0,
    this.content = '',
    this.poetName = '',
    this.poetryId = 0
  });

  factory JuItem.fromJson(dynamic item) {
    return JuItem(
        id: item['id'],
        content: item['content'],
        poetName: item.containsKey("poetName")? item['poetName'] : '佚名',
        poetryId: item['poetryId']
    );
  }
}