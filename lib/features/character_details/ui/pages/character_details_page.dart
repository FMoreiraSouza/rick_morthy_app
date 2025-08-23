import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/di/dependency_manager.dart';
import 'package:rick_morthy_app/core/ui/states/app_load_widget.dart';
import 'package:rick_morthy_app/domain/entities/character_entity.dart';
import 'package:rick_morthy_app/features/character_details/presentation/viewmodels/character_details_view_model.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int characterId;

  const CharacterDetailsPage({super.key, required this.characterId});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  final CharacterDetailsViewModel _viewModel = DependencyManager.get<CharacterDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChange);
    _loadCharacter();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  void _onViewModelChange() {
    setState(() {});
  }

  void _loadCharacter() {
    _viewModel.loadCharacter(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _viewModel.character != null
            ? Text(_viewModel.character!.name)
            : const Text('Detalhes do Personagem'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading && _viewModel.character == null) {
      return const AppLoadWidget(label: 'Carregando personagem...');
    }

    if (_viewModel.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erro: ${_viewModel.error}'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadCharacter, child: const Text('Tentar novamente')),
          ],
        ),
      );
    }

    if (_viewModel.character == null) {
      return const Center(child: Text('Personagem não encontrado'));
    }

    return _buildCharacterDetails(_viewModel.character!);
  }

  Widget _buildCharacterDetails(CharacterEntity character) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: 'character-${character.id}',
              child: Image.network(character.image, width: 200, height: 200, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoCard(character),
        ],
      ),
    );
  }

  Widget _buildInfoCard(CharacterEntity character) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nome', character.name),
            _buildInfoRow('Status', character.status),
            _buildInfoRow('Espécie', character.species),
            if (character.type.isNotEmpty) _buildInfoRow('Tipo', character.type),
            _buildInfoRow('Gênero', character.gender),
            _buildInfoRow('Origem', character.origin.name),
            _buildInfoRow('Localização', character.location.name),
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
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
