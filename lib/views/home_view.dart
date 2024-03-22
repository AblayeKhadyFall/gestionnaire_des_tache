import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez le package provider

import 'package:gestionnaire_des_tache/models/tache.dart';
import 'package:gestionnaire_des_tache/db.dart';
import 'package:gestionnaire_des_tache/views/edit_view.dart';
import 'package:gestionnaire_des_tache/views/editer_tache.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionnaire de Tâches'),
      ),
      body: StreamBuilder<List<Tache>>(
        stream: Provider.of<DatabaseService>(context)
            .recupererTaches(), // Utilisez le provider pour accéder à la méthode recupererTaches()
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Supprimer la tâche'),
                                  content: const Text(
                                      'Êtes-vous sûr de vouloir supprimer cette tâche ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<DatabaseService>(context,
                                                listen: false)
                                            .supprimerTache(tache
                                                .id); // Utilisez le provider pour accéder à la méthode supprimerTache()
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Supprimer'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTacheScreen(tacheToEdit: tache)),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${tache.description}'),
                        Text('Date de début: ${tache.dateDebut}'),
                        Text('Date de fin: ${tache.dateFin}'),
                        Text(
                          'État: ${tache.etat.toString().split('.').last}',
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
