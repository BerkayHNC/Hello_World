import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class  MyHomePage extends StatefulWidget{
  final String name;

  MyHomePage(this.name);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(text, widget.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Hello World!')), 
          body: Column(children: <Widget>[
              Expanded(child: PostList(this.posts)),
              TextInputWidget(this.newPost)
            ],
          )
          );
  }
}