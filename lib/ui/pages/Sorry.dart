import 'package:flutter/material.dart';

class ErrorSorry extends StatelessWidget {
  final String msg;

  ErrorSorry({
    Key key,
    this.msg,
  }) : super(key: key);

  List<String> randomSorryMeme = [
    "https://static.langimg.com/thumb/msid-68646656,imgsize-635755,width-540,height-405,resizemode-75/malayalam.samayam.com.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy54qNIHXDT_cbr2Xlr6k51jZBlSyeBd5iJg&usqp=CAU",
    "https://scontent-maa2-2.xx.fbcdn.net/v/t1.0-1/c75.0.448.448a/31369310_360647314444349_8869642318298267316_n.jpg?_nc_cat=103&_nc_sid=dbb9e7&_nc_ohc=CP4ltoy37JUAX9jtXxP&_nc_ht=scontent-maa2-2.xx&oh=d6c89c0afed694b28ff503a1f1b7fb38&oe=5F375D22"
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage((randomSorryMeme..shuffle()).first))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              msg,
              style: TextStyle(
                fontFamily: "Merriweather",
                fontSize: 26,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
