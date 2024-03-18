import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/views/edit_view.dart';
// Importez vos autres fichiers nécessaires ici, comme vos modèles, widgets, et le provider de tâches.

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionnaire de Tâches'),
      ),
      body: Center(
        child: Text('Liste des Tâches ici'),
        // Ici, vous allez vouloir afficher votre liste de tâches,
        // probablement en utilisant un ListView.builder et en accédant à vos données à travers un Provider.
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTacheScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
