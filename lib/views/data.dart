import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/drawner.dart';

void main() {
  runApp(const Data());
}

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}






class _PostsPageState extends State<PostsPage> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  //récupétation des données par une requtte http
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Erreur lors du chargement des posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Récupération des Données via API")),
      drawer: Drawner(),
      body: FutureBuilder<List<Post>>(
        future: futurePosts, //indique que l'on va écouter un état d'opération asynchrone 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {//vérifie l'opération a réussi
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {//teste si les données récupérer sont vides
            return const Center(child: Text('Aucun article trouvé'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical, // Permet défilement horizontal 
              child: DataTable(
                border: TableBorder.all(), // bordures du tableau
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('UsersID')),
                  DataColumn(label: Text('Titre')),
                  DataColumn(label: Text('Contenu')),
                ],
                rows: snapshot.data!.map((post) {
                  return DataRow(cells: [
                    DataCell(Center(child: Text(post.id.toString()))),
                    DataCell(Center(child: Text(post.userId.toString()))),
                    DataCell(Center(child: Text(post.title.toString()))),
                    DataCell(SizedBox(
                      width: 200, 
                      child: Text(post.body, overflow: TextOverflow.ellipsis),
                    )),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({required this.id, required this.userId, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
