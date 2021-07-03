import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poetryapp/models/ju_model.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/services/ju_service.dart';
import 'package:poetryapp/view/components/collection_card.dart';
import 'package:poetryapp/view/components/vertical_text.dart';
import 'package:poetryapp/view/sub_pages/potery_detail_page.dart';
import 'dart:math';
//这个文档实现了轮播图功能

var cardAspectRatio = 12.0 / 20.0; // 12:16  后面会用到的轮播图图片比例
var widgetAspectRatio = cardAspectRatio * 1.2;

class JuCardBanner extends StatefulWidget {
  late List<JuItem> juList;
  late List<PoetryItem> poetryList;
  late ValueChanged<double> changePageCallBack;
  JuCardBanner(
      {Key? key,
      required List<JuItem> juList,
      required List<PoetryItem> poetryList,
      required ValueChanged<double> changePageCallBack})
      : super(key: key) {
    this.juList = juList;
    this.poetryList = poetryList;
    this.changePageCallBack = changePageCallBack;
  }

  @override
  _JuCardBannerState createState() => new _JuCardBannerState();
}

class _JuCardBannerState extends State<JuCardBanner> {
  late var currentPage;

  @override
  void initState() {
    currentPage = widget.juList.length - 1.0;
    super.initState();
  }

  _navigate(BuildContext context, PoetryItem item) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => PoetryDetailPage(data: item)));
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: widget.juList.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page! as double;
        //返回当前页面的位置信息，浮点数型
      });
      widget.changePageCallBack(currentPage);
    });
    return Stack(
      children: <Widget>[
        CardScrollwidget(
          currentPage: currentPage,
          juList: widget.juList,
        ),
        // 通过pageView 改变state 改变currentpage
        Positioned.fill(
          child: PageView.builder(
              itemCount: widget.juList.length, //页面个数
              controller: controller,
              reverse: true, //手势与滑动方向相同
              itemBuilder: (context, index) {
                late PoetryItem item;
                for (var poetry in widget.poetryList) {
                  int id = widget.juList[index].poetryId;
                  if (poetry.Id == id) {
                    item = poetry;
                    break;
                  }
                }
                return InkWell(
                  child: Container(),
                  onTap: () {
                    _navigate(context, item);
                  },
                );
              }),
        )
      ],
    );
  }

}

class CardScrollwidget extends StatefulWidget {
  late double currentPage;

  late List<JuItem> juList;

  CardScrollwidget(
      {Key? key, required double currentPage, required List<JuItem> juList})
      : super(key: key) {
    this.currentPage = currentPage;
    this.juList = juList;
  }

  @override
  _CardScrollwidgetState createState() => _CardScrollwidgetState();
}

class _CardScrollwidgetState extends State<CardScrollwidget> {
  var padding = 20.0;
  var vericalInset = 20.0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      //将子部件调成特定宽高比
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeigh = height - 2 * padding;

        var heightOfPrimaryCard = safeHeigh;
        var widthOfPrimaryCard =
            heightOfPrimaryCard * cardAspectRatio; // 高 * 宽/高 = 宽

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = <Widget>[];
        if (widget.juList.length != 0) {
          for (var i = 0; i < widget.juList.length; i++) {
            var delta = i - widget.currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
                //这是轮播图的主要内容
                top: padding + vericalInset * max(-delta, 0.0),
                bottom: padding + vericalInset * max(-delta, 0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF415E89), width: 5),
                    ),
                    child: AspectRatio(
                        aspectRatio: cardAspectRatio,
                        child: Container(
                          //宽度是270
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Container(
                              //宽度是250
                              child: Stack(
                            children: <Widget>[
                              Positioned(
                                  width: 50,
                                  height: 440,
                                  child: Container(
//                                    color: Colors.white,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              top: BorderSide(
                                                  color: Color(0xFF415E89),
                                                  width: 1),
                                              left: BorderSide(
                                                  color: Color(0xFF415E89),
                                                  width: 1),
                                              bottom: BorderSide(
                                                  color: Color(0xFF415E89),
                                                  width: 1))),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            bottom: widget.juList[i].poetName.length * 24.0 + 60,
                                            child: CustomPaint(
                                            painter: VerticalText(
                                              text: widget.juList[i].poetName,
                                              textStyle: TextStyle(
                                                  color: Color(0xFF47525E),
                                                  fontFamily: 'FangZhengShuSongJianTi',
                                                  fontSize: 20,
                                                  letterSpacing: 10,
                                                  wordSpacing: 4),
                                              width: 10, //position.width - fontsize刚好顶格
                                              height: 440,
                                              y: 0,
                                            ),
                                          ),),
                                          Positioned(
                                            bottom: 15,
                                              left: 12,
                                              child: Image.asset(
                                            'images/poet.png',
                                            width: 30,
                                            height: 30,
                                          ))
                                        ],
                                      ))),
                              Positioned(
                                right: 0,
                                width: 210,
                                height: 440,
                                child: Container(
//                                    color: Colors.white,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xFF415E89),
                                            width: 1)),
                                    child: CustomPaint(
                                      painter: VerticalText(
                                        text: widget.juList[i].content,
                                        textStyle: TextStyle(
                                            color: Color(0xFF47525E),
                                            fontSize: 20,
                                            fontFamily: 'FangZhengShuSongJianTi',
                                            letterSpacing: 10,
                                            wordSpacing: 4),
                                        width:
                                            170, //position.width - fontsize刚好顶格
                                        height: 440,
                                        y: 20,
                                      ),
                                    )),
                              )
                            ],
                          )),
                        )),
                  ),
                ));

            cardList.add(cardItem);
          }
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
