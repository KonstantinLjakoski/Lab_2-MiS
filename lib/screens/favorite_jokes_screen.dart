import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;

  const FavoriteJokesScreen({Key? key, required this.favoriteJokes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Омилени шеги'),
      ),

      body: favoriteJokes.isEmpty
          ? Center(child: Text('Нема додадени омилени шеги.'))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),

          );
        },
      ),
    );
  }
}
