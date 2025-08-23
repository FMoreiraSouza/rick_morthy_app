import 'package:flutter/material.dart';
import 'package:rick_morthy_app/app_routes.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';
import 'package:rick_morthy_app/core/ui/states/app_load_widget.dart';
import 'package:rick_morthy_app/core/ui/states/flow_state_widget.dart';
import 'package:rick_morthy_app/features/character_list/presentation/viewmodels/character_view_model.dart';

class CharacterListPage extends StatefulWidget {
  final CharacterViewModel viewModel;

  const CharacterListPage({super.key, required this.viewModel});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChange);
    _scrollController.addListener(_onScroll);
    widget.viewModel.loadCharacters();
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    _scrollController.dispose();
    super.dispose();
  }

  void _onViewModelChange() => setState(() {});

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      widget.viewModel.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.viewModel.refreshCharacters,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.viewModel.isLoading && widget.viewModel.characters.isEmpty) {
      return const AppLoadWidget(label: 'Carregando personagens...');
    }

    if (widget.viewModel.hasError && widget.viewModel.characters.isEmpty) {
      return FlowStateWidget(
        function: widget.viewModel.refreshCharacters,
        title: 'Erro ao carregar',
        description: widget.viewModel.error,
        flowState: FlowState.error,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.viewModel.characters.length + (widget.viewModel.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.viewModel.characters.length) {
          return _buildLoadingMore();
        }

        final character = widget.viewModel.characters[index];
        return ListTile(
          leading: Image.network(character.image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(character.name),
          subtitle: Text('${character.status} - ${character.species}'),
          // No método onTap do ListTile:
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.characterDetails,
              arguments: {'character': character}, // Garantindo que sempre passamos o character
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingMore() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: widget.viewModel.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: widget.viewModel.loadNextPage,
                child: const Text('Carregar mais'),
              ),
      ),
    );
  }
}
