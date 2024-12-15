import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokeListScreen extends StatelessWidget {
  final String type;

  const JokeListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Шеги од тип: $type'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type), // Ова ја повикува функцијата од api_services.dart
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
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 3,
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
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
