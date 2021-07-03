import 'package:flutter/material.dart';
import 'package:poetryapp/models/poetry_model.dart';
import 'package:poetryapp/view/sub_pages/potery_detail_page.dart';

class PoetryCard extends StatefulWidget {

  late PoetryItem data;
  PoetryCard({Key? key, required PoetryItem data}) : super(key: key) {
    this.data = data;
  }

  @override
  _PoetryCardState createState() => _PoetryCardState();
}

class _PoetryCardState extends State<PoetryCard> {

  @override
  void initState() {
    super.initState();
  }


  _navigate (BuildContext context) async {

    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PoetryDetailPage(data: widget.data))
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 280,
                    child: Text(
                      widget.data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
//                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    width: 280,
                    child: Text(
                      widget.data.dynasty + '/' + widget.data.poet,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF415E89),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    width: 280,
                    child: Text(
                      widget.data.content.split('。')[0].trim() + '。',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                ],
              ),
//              IconButton(
//                  onPressed: () {
//                    _onIconPressed();
//                  },
//                  icon: Icon(iconData),
//                  color: iconColor
//              )
            ],
          )),
      onTap: () {
        _navigate(context);
      },
    );
  }
}

