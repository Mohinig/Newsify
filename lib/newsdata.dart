import 'dart:convert';
import 'package:newsify/model.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_dotenv/flutter_dotenv.dart';
class News{
  List<ArticleModel> news=[];
  static String query = '';
  Future<void> getNews()async{
  String url="http://newsapi.org/v2/top-headlines?country=in&apiKey=e7b5d261be014109a8e4db8c51a62994";

  var response =await http.get(url);

  var decodedData=jsonDecode(response.body);

  if(decodedData['status']=="ok"){
    decodedData["articles"].forEach((element) {
      if(element['urlToImage']!=null && element['description']!=null){
        String published=element['publishedAt'];
        var x=published.split('T');
        String date=x[0];
        ArticleModel articleModel=ArticleModel(
          title: element['title'],
          description: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          name:element['source']['name'],
          date: date,
        );
        news.add(articleModel);
      }
    });
  }
  }
}