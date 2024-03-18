import 'package:flutter/material.dart';
import '../models/tache.dart'; // Assurez-vous que le chemin d'importation est correct.

class TacheCard extends StatelessWidget {
  final Tache tache;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TacheCard({
    Key? key,
    required this.tache,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(tache.titre),
        subtitle: Text(tache.description),
        leading: CircleAvatar(
          // Choisissez une couleur en fonction de l'état de la tâche
          backgroundColor: _getColorForEtat(tache.etat),
          child: _getIconForEtat(tache.etat),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForEtat(EtatTache etat) {
    switch (etat) {
      case EtatTache.pasDebute:
        return Colors.grey;
      case EtatTache.enCours:
        return Colors.blue;
      case EtatTache.termine:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _getIconForEtat(EtatTache etat) {
    switch (etat) {
      case EtatTache.pasDebute:
        return Icon(Icons.hourglass_empty, color: Colors.white);
      case EtatTache.enCours:
        return Icon(Icons.construction, color: Colors.white);
      case EtatTache.termine:
        return Icon(Icons.check_circle_outline, color: Colors.white);
      default:
        return Icon(Icons.error_outline, color: Colors.white);
    }
  }
}
