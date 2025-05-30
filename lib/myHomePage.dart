import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hello_world/database.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class  MyHomePage extends StatefulWidget{
  final User user;

  MyHomePage(this.user);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    // Fix: Use widget.user.displayName instead of widget.displayName
    var post = new Post(text, widget.user.displayName ?? 'Anonymous');
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllPosts().then((posts) => {
      this.setState(() {
        this.posts = posts;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Hello World!')), 
          body: Column(children: <Widget>[
              Expanded(child: PostList(this.posts, widget.user)),
              TextInputWidget(this.newPost)
            ],
          )
          );
  }
}