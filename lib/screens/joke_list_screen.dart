import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokeListScreen extends StatefulWidget {
  final String type;

  const JokeListScreen({required this.type});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  final List<Joke> favoriteJokes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Шеги од тип: ${widget.type}'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(widget.type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Грешка при вчитување на шегите: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  elevation: 3,
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: Icon(
                        favoriteJokes.contains(joke)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoriteJokes.contains(joke)
                            ? Colors.red
                            : null,
                      ),
                      onPressed: () {
                        setState(() {
                          if (favoriteJokes.contains(joke)) {
                            favoriteJokes.remove(joke);
                          } else {
                            favoriteJokes.add(joke);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(favoriteJokes.contains(joke)
                                ? 'Додадено во омилени!'
                                : 'Тргнато од омилени!'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Нема достапни шеги за овој тип.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
