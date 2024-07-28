import 'package:flutter/material.dart';
import 'package:project_graduated/provide/language_provider.dart';
import 'package:provider/provider.dart';

class Rulesscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(languageProvider.getText('rules_of_inheritance')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: languageProvider.currentLanguage,
              icon: Icon(Icons.language, color: Colors.blue),
              underline: SizedBox(),
              dropdownColor: Colors.white,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  languageProvider.changeLanguage(newValue);
                }
              },
              items: <String>['en', 'so']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value.toUpperCase(),
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRuleCard(context, 'rule_1'),
          _buildRuleCard(context, 'husband'),
          _buildRuleCard(context, 'widow'),
          _buildRuleCard(context, 'father'),
          _buildRuleCard(context, 'mother'),
          _buildRuleCard(context, 'daughter'),
          _buildRuleCard(context, 'full_sister'),
          _buildRuleCard(context, 'law_of_increase'),
          _buildRuleCard(context, 'law_of_return'),
          _buildRuleCard(context, 'residuaries'),
        ],
      ),
    );
  }

  Widget _buildRuleCard(BuildContext context, String ruleKey) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          languageProvider.getText(ruleKey),
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
