import 'package:flutter/material.dart';
import 'package:rick_morthy_app/app_routes.dart';
import 'package:rick_morthy_app/core/constants/screen_states.dart';
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

  void _onViewModelChange() {
    setState(() {});
  }

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
      body: Stack(
        children: [
          _buildBody(),
          if (widget.viewModel.isLoading && widget.viewModel.characters.isNotEmpty)
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, child) {
        return _getWidget(widget.viewModel.state);
      },
    );
  }

  Widget _getWidget(int state) {
    switch (state) {
      case ScreenStates.successState:
        return _buildCharacterList();
      case ScreenStates.emptyState:
        return FlowStateWidget(
          title: 'Nenhum personagem encontrado',
          description: 'Não encontramos nenhum personagem para exibir.',
          hideButton: true,
          flowState: FlowState.empty,
        );
      case ScreenStates.loadingState:
        return const AppLoadWidget(label: 'Carregando personagens...');
      case ScreenStates.errorState:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Erro ao carregar',
          description: widget.viewModel.error,
          flowState: FlowState.error,
        );
      default:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Erro desconhecido',
          description: 'Ocorreu um erro inesperado.',
          flowState: FlowState.error,
        );
    }
  }

  Widget _buildCharacterList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.viewModel.characters.length,
      itemBuilder: (context, index) {
        final character = widget.viewModel.characters[index];
        return ListTile(
          leading: Image.network(character.image),
          title: Text(character.name),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.characterDetails,
              arguments: {'characterId': character.id},
            );
          },
        );
      },
    );
  }
}
