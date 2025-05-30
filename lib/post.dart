import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  late DatabaseReference _id;


  Post(this.body, this.author);

  void likePost(User user) {
    if(this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    // Update the likes in Firebase
    _id.update({'usersLiked': usersLiked.toList()});
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author, 
      'usersLiked': this.usersLiked.toList(), 
      'body':this.body
    };
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': '' 
  };

  record.forEach((key,value) => {attributes[key] = value});

  Post post = new Post(attributes['body'], attributes['author']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  return post;
}