import 'package:flutter/material.dart';
import 'package:newsify/read.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
class Article extends StatelessWidget {
  final String imageUrl,title,des,url,name,date;
  final List<String> choices = ['Open with Browser'];
  Article({@required this.imageUrl,this.title,this.des,this.url,this.name,this.date});
  void choiceOption(String choice) {
    if (choice == 'Open with Browser') {
      _launchInBrowser();
    }
  }

  Future<void> _launchInBrowser() async {
    if (await canLaunch(this.url)) {
      await launch(this.url, forceWebView: false);
    } else {
      throw 'Could not launch ${this.url}';
    }
  }

  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final String sharedText =
        '${this.title}\n\nRead more about this topic-\n${this.url}';
    Share.share(sharedText,
        subject: this.title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(
            builder: (context) => ReadPage(
              posturl: url,
            )
        ));
      },
        child: Container(
        decoration: BoxDecoration(
          color:Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.only(left:10,right:10,top:5,bottom:5),
        margin: EdgeInsets.only(top:7,right:7,left:7),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[ 
                         Expanded(
                          child: Column(children:<Widget>[
                          Text(title,style: TextStyle(fontSize:15.0,fontWeight:FontWeight.bold,),),
                          SizedBox(height: 7,),
                          Text(des,style:TextStyle(fontSize:10.0,),maxLines:2),
                           ],
                          ),
                        ),
                        SizedBox(width:10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:CachedNetworkImage(imageUrl:imageUrl,height:85.0,width:85.0,fit: BoxFit.cover,),),
                  ],
            ),
            SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(name,style:TextStyle(fontSize:13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                        SizedBox(width:5),
                        Text('-'),
                        SizedBox(width:5),
                         Text(date),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                           icon: Icon(Icons.share),
                            onPressed: ()=> share(context),
                         ),
                          PopupMenuButton<String>(
            onSelected: choiceOption,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
                      ],
                    )
                  ],
                ),
          ],
        ),
      ),
    );  
  }
}
