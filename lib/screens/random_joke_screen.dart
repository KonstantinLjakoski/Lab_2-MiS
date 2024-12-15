import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart'; //

class RandomJokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(), // Правилно повикување на ApiService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    joke.setup,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    joke.punchline,
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No joke found.'));
          }
        },
      ),
    );
  }
}
