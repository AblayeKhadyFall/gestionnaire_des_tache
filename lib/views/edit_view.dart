import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/db.dart';
import 'package:gestionnaire_des_tache/models/tache.dart';
// Importez ici votre modèle Tache et autres dépendances nécessaires.

class AddEditTacheScreen extends StatefulWidget {
  @override
  _AddEditTacheScreenState createState() => _AddEditTacheScreenState();
}

class _AddEditTacheScreenState extends State<AddEditTacheScreen> {
  final _formKey = GlobalKey<FormState>();
  // Définissez ici les contrôleurs et variables nécessaires pour gérer les entrées de l'utilisateur et l'état du formulaire.
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateDebutController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController etatTacheController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter / Éditer une Tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                // Contrôleur, décorations et validations pour le titre
                controller: titreController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                // Contrôleur, décorations et validations pour la description
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              TextFormField(
                // Contrôleur, décorations et validations pour la date de début
                controller: dateDebutController,
                decoration: const InputDecoration(
                  labelText: 'Date de début',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer une date de début';
                  }
                  return null;
                },
              ),
              TextFormField(
                // Contrôleur, décorations et validations pour la date de fin
                controller: dateFinController,
                decoration: const InputDecoration(
                  labelText: 'Date de fin',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer une date de fin';
                  }
                  return null;
                },
              ),
              TextFormField(
                // Contrôleur, décorations et validations pour l'état de la tâche
                controller: etatTacheController,
                decoration: const InputDecoration(
                  labelText: 'État de la tâche',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer un état de la tâche';
                  }
                  return null;
                },
              ),

              // Ajoutez ici d'autres champs de formulaire pour la date de début, date de fin, et l'état de la tâche.
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Création de l'instance Tache à partir des entrées utilisateur
                    Tache nouvelleTache = Tache(
                      id: DateTime.now().toString(),
                      titre: titreController.text,
                      description: descriptionController.text,
                      dateDebut: dateDebutController.text,
                      dateFin: dateFinController.text,
                      etat: EtatTache.values.firstWhere(
                          (etat) => etat.toString() == etatTacheController.text,
                          orElse: () => EtatTache
                              .pasDebute), // Exemple de gestion de l'état
                    );

                    try {
                      // Utilisation de votre service DatabaseService pour ajouter la tâche
                      await DatabaseService().ajouterTache(nouvelleTache);
                      // Affichage d'un message de succès ou de navigation vers un autre écran si nécessaire
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tâche ajoutée avec succès")));
                      Navigator.of(context)
                          .pop(); // Retour à l'écran précédent ou à l'écran d'accueil
                    } catch (e) {
                      // Gestion des erreurs (par exemple, affichage d'une alerte à l'utilisateur)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Erreur lors de l'ajout de la tâche")));
                    }
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
