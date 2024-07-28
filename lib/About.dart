import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Inheritance System'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.teal[50]!], // Light gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'About Inheritance System',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Divider(color: Colors.teal),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Introduction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'The Inheritance System application is designed to facilitate the calculation and distribution of inheritance according to Islamic principles. It aims to provide a user-friendly and accurate tool for individuals and families to ensure the fair distribution of assets as outlined in Islamic law.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '1. Accurate Calculation: The application uses the principles of Islamic inheritance law to calculate shares for various heirs.\n'
                          '2. User-Friendly Interface: Easy-to-use forms and clear instructions ensure a smooth user experience.\n'
                          '3. Quranic References: Provides relevant Quranic references to help users understand the basis of the calculations.\n'
                          '4. Detailed Results: Displays detailed results including the shares of each heir and their Quranic references.\n'
                          '5. Historical Records: Allows users to save and view past calculations for reference.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'How It Works',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Users simply input the details of the deceased\'s estate and the number of heirs. The application then calculates the shares based on Islamic principles and displays the results along with the relevant Quranic references.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Quranic References',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'The Quran provides detailed instructions on inheritance in several verses, including:',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Surah An-Nisa (4:11)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[700],
                          ),
                        ),
                        Text(
                          'يُوصِيكُمُ اللَّهُ فِي أَوْلَادِكُمْ ۖ لِلذَّكَرِ مِثْلُ حَظِّ الأُنثَيَيْنِ...',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontFamily: 'Arial',
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Surah An-Nisa (4:12)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[700],
                          ),
                        ),
                        Text(
                          'وَلَكُمْ نِصْفُ مَا تَرَكَ أَزْوَاجُكُمْ إِنْ لَمْ يَكُنْ لَهُنَّ وَلَدٌ...',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontFamily: 'Arial',
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Conclusion',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'The Inheritance System application is a valuable tool for those seeking to manage inheritance matters in accordance with Islamic law. By ensuring accurate calculations and providing clear, detailed results, it helps users fulfill their religious obligations and promote fairness and justice.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}