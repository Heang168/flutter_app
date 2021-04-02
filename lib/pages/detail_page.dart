import '../models/article_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Article article;
  DetailPage({this.article});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      title: Text("${widget.article.shopName}"),
      centerTitle: true,
      backgroundColor: Colors.lightBlue,
    );
  }

  get _buildBody{
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Image(image: NetworkImage("${widget.article.img}"), fit: BoxFit.contain, height: 300,),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Discount: ${widget.article.discount} OFF", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.left ,),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child:Text('${widget.article.discription}'),
          ),
        ],
      ),
    );

  }

}