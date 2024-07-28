import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_graduated/screens/Sigin_screen.dart';
import 'package:project_graduated/dashboard.dart';
import 'package:project_graduated/provide/language_provider.dart';
import 'package:project_graduated/provide/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => Provider.of<UserProvider>(context, listen: false)
        .loadUserFromStorage());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return userProvider.user != null ? const Dashboard() : const SigIn();
      }),
    );
  }
}
