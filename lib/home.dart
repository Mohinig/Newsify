import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsify/newsdata.dart';
import 'package:newsify/article.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newsList;
  bool _loading=true;
  Widget apptitle=Text('Newsify');
  @override
  void initState(){
    _loading =true;
    super.initState();
    getNews();
  }
  void getNews() async{
    News news= News();
    await news.getNews();
    newsList =news.news;
    setState(() {
      _loading=false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:apptitle,
        elevation: 2.0,
        actions: <Widget>[

        ],   
      ),
      body:SafeArea(
        child: _loading?Center(
          child:CircularProgressIndicator(),):
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top:10),
               child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: newsList.length,
                physics: ClampingScrollPhysics(),
                 itemBuilder:(context,index){
                   return Article(imageUrl:newsList[index].urlToImage,
                   title: newsList[index].title, 
                   des:newsList[index].description,
                   url:newsList[index].url,
                   name:newsList[index].name,
                   date:newsList[index].date,
                   );
                 }
               ),
                ),
            ),
      ),  
     );
  }
}

