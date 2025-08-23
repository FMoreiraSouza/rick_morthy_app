import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';
import 'package:rick_morthy_app/core/ui/states/app_load_widget.dart';
import 'package:rick_morthy_app/core/ui/states/flow_state_widget.dart';
import 'package:rick_morthy_app/features/character_details/presentation/viewmodel/character_details_view_model.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterDetailsViewModel viewModel;

  const CharacterDetailsPage({super.key, required this.viewModel});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  void _onViewModelChange() => setState(() {});

  void _fetchArguments(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    widget.viewModel.fetchArguments(args);
  }

  @override
  Widget build(BuildContext context) {
    _fetchArguments(context);

    return Scaffold(
      appBar: AppBar(
        title: widget.viewModel.character != null
            ? Text(widget.viewModel.character!.name)
            : const Text('Detalhes do Personagem'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.viewModel.isLoading) {
      return const AppLoadWidget(label: 'Carregando personagem...');
    }

    if (widget.viewModel.hasError || widget.viewModel.character == null) {
      return FlowStateWidget(
        title: 'Erro',
        description: widget.viewModel.error.isNotEmpty
            ? widget.viewModel.error
            : 'Personagem não disponível',
        flowState: FlowState.error,
      );
    }

    return _buildCharacterDetails();
  }

  Widget _buildCharacterDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              widget.viewModel.character!.image,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoCard(),
        ],
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
            _buildInfoRow('Nome', widget.viewModel.character!.name),
            _buildInfoRow('Status', widget.viewModel.character!.status),
            _buildInfoRow('Espécie', widget.viewModel.character!.species),
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
