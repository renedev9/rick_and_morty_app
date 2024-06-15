import 'package:flutter/material.dart';

import '../../domain/models/models_export.dart';

class CharacterListTite extends StatelessWidget {
  const CharacterListTite({
    super.key,
    // required this.lista,
    required this.character,
  });

  // final List<CharacterModel> lista;
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(character.id.toString()),
      title: Text(character.name),
      subtitle: Text(
          '${character.species.toString().replaceAll('Species.', '')} ${character.status.toString().replaceAll('Status.', '')}'),
    );
  }
}