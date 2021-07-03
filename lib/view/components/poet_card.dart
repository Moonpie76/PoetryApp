import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poetryapp/models/poet_model.dart';
import 'package:poetryapp/view/sub_pages/poet_detail_page.dart';

class PoetCard extends StatefulWidget {

  late PoetItem data;

  PoetCard({
    Key? key,
    required PoetItem data
  }) : super(key: key) {
    this.data = data;
  }

  @override
  _PoetCardState createState() => _PoetCardState();
}

class _PoetCardState extends State<PoetCard> {

  _navigate (BuildContext context) async {

    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PoetDetailPage(data: widget.data))
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: new CachedNetworkImage(
                imageUrl: widget.data.image,
                width: 60,
                height: 60,
                placeholder: (context, url) => Container(
                  width: 5,
                  height: 5,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.data.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        widget.data.dynasty,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    widget.data.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _navigate(context);
      },
    );
  }
}


