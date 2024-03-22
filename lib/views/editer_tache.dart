import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/db.dart';
import 'package:gestionnaire_des_tache/models/tache.dart';
// Importez ici votre modèle Tache et autres dépendances nécessaires.

class EditTacheScreen extends StatefulWidget {
  final Tache tacheToEdit;

  const EditTacheScreen({Key? key, required this.tacheToEdit})
      : super(key: key);

  @override
  _EditTacheScreenState createState() => _EditTacheScreenState();
}

class _EditTacheScreenState extends State<EditTacheScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateDebutController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController etatTacheController = TextEditingController();
  EtatTache? _etatSelectionne;

  @override
  void initState() {
    super.initState();
    titreController.text = widget.tacheToEdit.titre;
    descriptionController.text = widget.tacheToEdit.description;
    dateDebutController.text = widget.tacheToEdit.dateDebut;
    dateFinController.text = widget.tacheToEdit.dateFin;
    _etatSelectionne = widget.tacheToEdit.etat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Éditer une Tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
                controller: descriptionController,
                decoration: const InputDecoration(
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
              DropdownButtonFormField<EtatTache>(
                decoration: const InputDecoration(
                  labelText: 'État de la tâche',
                ),
                value: _etatSelectionne,
                onChanged: (EtatTache? nouvelEtat) {
                  setState(() {
                    _etatSelectionne = nouvelEtat;
                  });
                },
                items:
                    EtatTache.values.map<DropdownMenuItem<EtatTache>>((etat) {
                  return DropdownMenuItem<EtatTache>(
                    value: etat,
                    child: Text(etat.toString().split('.').last),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Veuillez sélectionner un état' : null,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    Tache tacheModifiee = Tache(
                      id: widget.tacheToEdit.id,
                      titre: titreController.text,
                      description: descriptionController.text,
                      dateDebut: dateDebutController.text,
                      dateFin: dateFinController.text,
                      etat: _etatSelectionne ?? EtatTache.pasDebute,
                    );

                    try {
                      await DatabaseService().mettreAJourTache(tacheModifiee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tâche modifiée avec succès"),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Erreur lors de la modification de la tâche: $e",
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
