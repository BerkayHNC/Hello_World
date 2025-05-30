import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

final databaseReference = FirebaseDatabase.instance.ref();

void initializeDatabase() {
  FirebaseDatabase.instance.databaseURL = 'https://messageapp-5bc4d-default-rtdb.europe-west1.firebasedatabase.app';
}

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts').push();
  id.set(post.toJson()).then((_) {
    print('Post saved successfully');
  }).catchError((error) {
    print('Error saving post: $error');
  });
  return id;
}

Future<List<Post>> getAllPosts() async {
  DatabaseEvent event = await databaseReference.child('posts/').once();
  List<Post> posts = [];
  if(event.snapshot.value != null){

    Map<dynamic, dynamic> values = event.snapshot.value as Map;
    values.forEach((key,value)  {
      var post = createPost(value);
      post.setId(databaseReference.child('posts/').child(key));
      posts.add(post);
    });
  }
  return posts;
}