import 'package:flutter/material.dart';
import 'package:gestionnaire_des_tache/db.dart';
import 'package:gestionnaire_des_tache/models/tache.dart';
import 'package:provider/provider.dart'; // Importez le package provider

class AddEditTacheScreen extends StatefulWidget {
  @override
  _AddEditTacheScreenState createState() => _AddEditTacheScreenState();
}

class _AddEditTacheScreenState extends State<AddEditTacheScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateDebutController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController etatTacheController = TextEditingController();
  EtatTache? _etatSelectionne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                  controller: dateDebutController,
                  decoration: const InputDecoration(
                    labelText: 'Date de début',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer une date de début';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      dateDebutController.text = selectedDate.toString();
                    }
                  },
                ),
                TextFormField(
                  controller: dateFinController,
                  decoration: const InputDecoration(
                    labelText: 'Date de fin',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez entrer une date de fin';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      dateFinController.text = selectedDate.toString();
                    }
                  },
                  // Ajoutez un icône de calendrier ici
                  // Par exemple : suffixIcon: Icon(Icons.calendar_today),
                ),
                DropdownButtonFormField<EtatTache>(
                  decoration: InputDecoration(labelText: 'État de la tâche'),
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
                      Tache nouvelleTache = Tache(
                        id: DateTime.now().toString(),
                        titre: titreController.text,
                        description: descriptionController.text,
                        dateDebut: dateDebutController.text,
                        dateFin: dateFinController.text,
                        etat: _etatSelectionne ?? EtatTache.pasDebute,
                      );

                      try {
                        await DatabaseService().ajouterTache(nouvelleTache);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Tâche ajoutée avec succès")));
                        Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Erreur lors de l'ajout de la tâche")));
                      }
                    }
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TacheProvider extends ChangeNotifier {
  EtatTache? _etatSelectionne;

  EtatTache? get etatSelectionne => _etatSelectionne;

  void setEtatSelectionne(EtatTache? etat) {
    _etatSelectionne = etat;
    notifyListeners();
  }
}

// Utilisez le ChangeNotifierProvider pour envelopper votre écran
class AddEditTacheScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TacheProvider(),
      child: AddEditTacheScreen(),
    );
  }
}
