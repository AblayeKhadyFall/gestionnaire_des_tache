import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/views/home_view.dart';
import 'package:provider/provider.dart';
import 'providers/taches_provider.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Initialiser les liaisons de Flutter.
  await Firebase.initializeApp(
    // Initialiser Firebase de manière asynchrone.
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDMISg0-Uvc1lZa0RfDi1xEoQE7Iqam3eU',
      appId: '1:51883376944:android:659f94f5fcc3477d6648f5',
      messagingSenderId: '51883376944',
      projectId: 'gestionnaire-des-taches-d04ff',
      storageBucket: 'gestionnaire-des-taches-d04ff.appspot.com',
    ),
  );
  runApp(MyApp()); // Exécuter l'application.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TachesProvider()),
      ],
      child: MaterialApp(
        title: 'Gestionnaire de Tâches',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
