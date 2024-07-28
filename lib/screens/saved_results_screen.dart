import 'package:flutter/material.dart';

import 'package:project_graduated/screens/result_screen.dart';
import 'api_service.dart';

class SavedResultsScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiService.getResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          } else {
            List<Map<String, dynamic>> results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> result = results[index];
                double totalAmount = result['totalAmount'] ?? 0.0;
                return ListTile(
                  title: Text('Result #${index + 1}'),
                  subtitle: Text('Total Amount: ${totalAmount.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(result: result),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}