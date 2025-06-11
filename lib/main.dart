import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// pages
import 'package:myapp/pages/add_name.dart';
import 'package:myapp/pages/edit_name.dart';
import 'package:myapp/pages/home_page.dart';
/////////////////////////////////////////////
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crud Renata",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddName(),
        '/edit': (context) => const EditName(),
      },  
    );
  }
}