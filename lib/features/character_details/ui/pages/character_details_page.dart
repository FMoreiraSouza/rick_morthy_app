import 'package:flutter/material.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterEntity? character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.character == null) {
      // Fallback simples sem tratamento de erro complexo
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do Personagem')),
        body: const Center(child: Text('Personagem não disponível')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.character!.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.character!.image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nome', widget.character!.name),
            _buildInfoRow('Status', widget.character!.status),
            _buildInfoRow('Espécie', widget.character!.species),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
