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
    // Se estiver no estado de loading inicial, mostra apenas o loading
    if (widget.viewModel.state == ScreenStates.loadingState &&
        widget.viewModel.characters.isEmpty) {
      return const AppLoadWidget(label: 'Carregando personagens');
    }

    // Para outros estados, mostra o widget principal com loading overlay apenas para paginação
    return Stack(
      children: [
        // Widget principal baseado no estado
        _getWidget(widget.viewModel.state),

        // Loading overlay apenas para paginação (quando já tem dados)
        if (widget.viewModel.isLoading && widget.viewModel.characters.isNotEmpty)
          const Positioned.fill(child: AppLoadWidget()),
      ],
    );
  }

  Widget _getWidget(int state) {
    switch (state) {
      case ScreenStates.successState:
        return _buildCharacterList();
      case ScreenStates.emptyState:
        return FlowStateWidget(
          title: 'Nenhum personagem encontrado',
          description: 'Não há personagens disponíveis no momento.',
          hideButton: true,
          flowState: FlowState.empty,
        );
      case ScreenStates.loadingState:
        // Este caso só será chamado quando não houver personagens
        return const AppLoadWidget(label: 'Carregando personagens');
      case ScreenStates.noConnection:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Sem conexão',
          description: 'Verifique sua conexão com a internet e tente novamente.',
          flowState: FlowState.noConnection,
        );
      case ScreenStates.errorState:
      default:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Erro ao carregar',
          description: widget.viewModel.error,
          flowState: FlowState.error,
        );
    }
  }

  Widget _buildCharacterList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.viewModel.characters.length + (widget.viewModel.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.viewModel.characters.length) {
          // Mostrar um loading simples no final da lista para paginação
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final character = widget.viewModel.characters[index];
        return ListTile(
          leading: Image.network(
            character.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          title: Text(character.name),
          subtitle: Text(character.species),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.characterDetails,
              arguments: {'character': character},
            );
          },
        );
      },
    );
  }
}
