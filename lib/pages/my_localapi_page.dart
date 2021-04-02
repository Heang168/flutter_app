import '../models/article_model.dart';
import '../repo/my_localapi_repo.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';

class MyLocalAPIPage extends StatefulWidget {
  @override
  _MyLocalAPIPageState createState() => _MyLocalAPIPageState();
}

class _MyLocalAPIPageState extends State<MyLocalAPIPage> {
  Future _articleData;

  List<Article> _articleList;

  @override
  void initState() {
    super.initState();
    _articleData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      title: Text("Discount"),
      backgroundColor: Colors.blue,
    );
  }

  get _buildBody {
    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlueAccent,
      child: _buildFutureReader,
    );
  }

  get _buildFutureReader {
    return FutureBuilder<ArticleData>(
        future: _articleData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            _articleList = snapshot.data.articles;
            return _buildListView;
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  get _buildListView {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _articleData = getData();
        });
      },
      child: ListView.builder(
          itemCount: _articleList.length,
          itemBuilder: (context, index) {
            return _buildItem(_articleList[index]);
          }),
    );
  }

  String _noImgs =
      "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png";

  _buildItem(Article article) {
    article.img = article.img == "" ? _noImgs : article.img;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white60,
        // color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),

      ),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10.0
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, 'detail_page');
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => DetailPage(article: article,),
                    ),
                  );
                },
                child: Image.network(
                  article.img,
                  fit: BoxFit.cover,
                  height: 250,
                ),
              )

            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${article.shopName}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "${article.discount} Off",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
