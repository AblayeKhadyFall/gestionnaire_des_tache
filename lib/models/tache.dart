// lib/models/tache.dart
class Tache {
  final String id;
  final String titre;
  final String description;
  final String dateDebut;
  final String dateFin;
  final EtatTache etat;

  Tache({
    required this.id,
    required this.titre,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
    required this.etat,
  });

  // Convertir un objet Tache en Map. Utile pour la base de données.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'etat': etat.index,
    };
  }

  // Créer un objet Tache à partir d'une Map. Utile pour la base de données.
  factory Tache.fromMap(Map<String, dynamic> map) {
    return Tache(
      id: map['id'],
      titre: map['titre'],
      description: map['description'],
      dateDebut: map['dateDebut'],
      dateFin: map['dateFin'],
      etat: EtatTache.values[map['etat']],
    );
  }
}

enum EtatTache { pasDebute, enCours, termine }
