import 'package:flutter/material.dart';
import '../models/tache.dart';

class TachesProvider with ChangeNotifier {
  final List<Tache> _taches = [];

  List<Tache> get taches => List.unmodifiable(_taches);

  void ajouterTache(
      String titre, String description, String dateDebut, String dateFin) {
    final nouvelleTache = Tache(
      id: DateTime.now()
          .toString(), // Utiliser un identifiant unique pour chaque tâche.
      titre: titre,
      description: description,
      dateDebut: dateDebut,
      dateFin: dateFin,
      etat:
          EtatTache.pasDebute, // État initial lors de la création de la tâche.
    );

    _taches.add(nouvelleTache);
    notifyListeners();
  }

  void supprimerTache(String id) {
    _taches.removeWhere((tache) => tache.id == id);
    notifyListeners();
  }

  void modifierTache(String id, String nouveauTitre, String nouvelleDescription,
      String nouveauDateDebut, String nouveauDateFin, EtatTache nouvelEtat) {
    final index = _taches.indexWhere((tache) => tache.id == id);
    if (index >= 0) {
      _taches[index] = Tache(
        id: id,
        titre: nouveauTitre,
        description: nouvelleDescription,
        dateDebut: nouveauDateDebut,
        dateFin: nouveauDateFin,
        etat: nouvelEtat,
      );
      notifyListeners();
    }
  }

  void marquerCommeTermine(String id) {
    final index = _taches.indexWhere((tache) => tache.id == id);
    if (index >= 0) {
      final tache = _taches[index];
      _taches[index] = Tache(
        id: tache.id,
        titre: tache.titre,
        description: tache.description,
        dateDebut: tache.dateDebut,
        dateFin: tache.dateFin,
        etat: EtatTache.termine,
      );
      notifyListeners();
    }
  }
}
