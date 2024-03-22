import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestionnaire_des_tache/models/tache.dart';

class DatabaseService {
  final CollectionReference _tachesCollection =
      FirebaseFirestore.instance.collection('taches');

  // Ajouter une nouvelle tâche
  Future<void> ajouterTache(Tache tache) async {
    await _tachesCollection.add({
      'titre': tache.titre,
      'description': tache.description,
      'dateDebut': tache.dateDebut, // Convertir en String
      'dateFin': tache.dateFin, // Convertir en String
      'etat': tache.etat.index, // Utiliser index pour un stockage plus facile
    });
  }

  // Mettre à jour une tâche
  // Mettre à jour une tâche
  Future<void> mettreAJourTache(Tache tache) async {
    return await _tachesCollection.doc(tache.id).update({
      'titre': tache.titre,
      'description': tache.description,
      'dateDebut': tache.dateDebut,
      'dateFin': tache.dateFin,
      'etat': tache.etat.index, // JE DOIT UTILISER L'INDEX
    });
  }

  // Supprimer une tâche
  Future<void> supprimerTache(String id) async {
    return await _tachesCollection.doc(id).delete();
  }

  // Récupérer toutes les tâches
  Stream<List<Tache>> recupererTaches() {
    return _tachesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Tache(
          id: doc.id,
          titre: doc['titre'],
          description: doc['description'],
          dateDebut: doc['dateDebut'],
          dateFin: doc['dateFin'],
          etat: EtatTache.values[doc['etat']],
        );
      }).toList();
    });
  }
}
