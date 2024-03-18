import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/models/tache.dart'; // Assurez-vous que le modèle Tache est correctement importé.
import 'package:gestionnaire_des_tache/db.dart'; // Remplacez par le chemin correct de votre DatabaseService.
import 'package:gestionnaire_des_tache/views/edit_view.dart';
// Importez vos autres fichiers nécessaires ici, comme vos modèles, widgets, et le provider de tâches.

class HomeScreen extends StatelessWidget {
  final DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionnaire de Tâches'),
      ),
      body: StreamBuilder<List<Tache>>(
        stream: _dbService.recupererTaches(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Tache tache = snapshot.data![index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(tache.titre),
                        ),
                        IconButton(
                          onPressed: () {
                            // Logique de suppression de la tâche
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            // Logique d'édition de la tâche
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    // Reste du code inchangé..

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${tache.description}'),
                        Text('Date de début: ${tache.dateDebut}'),
                        Text('Date de fin: ${tache.dateFin}'),
                        // Exemple de style appliqué directement sur un widget Text pour l'état de la tâche
                        Text(
                          'État: ${tache.etat.toString().split('.').last}', // Pour un affichage plus lisible de l'état
                          style: TextStyle(
                            color: tache.etat == EtatTache.termine
                                ? Colors.green
                                : tache.etat == EtatTache.enCours
                                    ? Colors.blue
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    // Vous pouvez ajouter d'autres informations ici, comme la date de début, la date de fin, etc.
                  );
                },
              );
          }
        },
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
