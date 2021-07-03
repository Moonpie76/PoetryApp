import 'package:flutter/material.dart';
import 'package:poetryapp/models/book_collection_model.dart';
import 'package:poetryapp/view/sub_pages/book_page.dart';

class CollectionCard extends StatelessWidget {
  late BookCollectionItem data;

  CollectionCard({
    Key? key,
    required BookCollectionItem data
  }) : super(key: key) {
    this.data = data;
  }

  _navigate (BuildContext context) async {

    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookPage(page: data.collection, title: data.name,))
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
          margin: EdgeInsets.only(top: 15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16/7,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  child: Image.asset(
                    data.picture,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                      this.data.name,
                      style: TextStyle(
                        fontSize: 25,
//                        fontWeight: FontWeight.w500,
                        fontFamily: 'FangZhengShuSongFanTi',
                        color: Color(0xFF333333),
                      )
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    this.data.ju,
                    style: TextStyle(
                      fontSize: 15,
//                      fontFamily: 'FangZhengShuSongJianTi',
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
        ),
      onTap: () { _navigate(context); },
    );
  }
}
