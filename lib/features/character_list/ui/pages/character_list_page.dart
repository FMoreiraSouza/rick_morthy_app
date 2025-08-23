import 'package:flutter/material.dart';
import 'package:rick_morthy_app/app_routes.dart';
import 'package:rick_morthy_app/core/constants/responsivity_contants.dart';
import 'package:rick_morthy_app/core/constants/screen_states.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';
import 'package:rick_morthy_app/core/ui/states/app_load_widget.dart';
import 'package:rick_morthy_app/core/ui/states/flow_state_widget.dart';
import 'package:rick_morthy_app/core/utils/responsivity_utils.dart';
import 'package:rick_morthy_app/features/character_list/presentation/viewmodels/character_list_view_model.dart';

class CharacterListPage extends StatefulWidget {
  final CharacterListViewModel viewModel;

  const CharacterListPage({super.key, required this.viewModel});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();
  late ResponsivityUtils responsivity;

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
    responsivity = ResponsivityUtils(context);

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
    if (widget.viewModel.state == ScreenStates.loadingState &&
        widget.viewModel.characters.isEmpty) {
      return AppLoadWidget(
        label: 'Carregando personagens',
        padding: responsivity.responsiveAllPadding(ResponsivityConstants.verticalPaddingPercentage),
      );
    }

    return Stack(
      children: [
        _getWidget(widget.viewModel.state),
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
          responsivity: responsivity,
        );
      case ScreenStates.loadingState:
        return AppLoadWidget(
          label: 'Carregando personagens',
          padding: responsivity.responsiveAllPadding(
            ResponsivityConstants.verticalPaddingPercentage,
          ),
        );
      case ScreenStates.noConnection:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Sem conexão',
          description: 'Verifique sua conexão com a internet e tente novamente.',
          flowState: FlowState.noConnection,
          responsivity: responsivity,
        );
      case ScreenStates.errorState:
      default:
        return FlowStateWidget(
          function: widget.viewModel.refreshCharacters,
          title: 'Erro ao carregar',
          description: widget.viewModel.error,
          flowState: FlowState.error,
          responsivity: responsivity,
        );
    }
  }

  Widget _buildCharacterList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.viewModel.characters.length + (widget.viewModel.hasMore ? 1 : 0),
      padding: responsivity.responsivePadding(
        horizontalPercentage: ResponsivityConstants.horizontalPaddingPercentage,
        verticalPercentage: ResponsivityConstants.verticalPaddingPercentage,
      ),
      itemBuilder: (context, index) {
        if (index >= widget.viewModel.characters.length) {
          return Padding(
            padding: EdgeInsets.all(responsivity.defaultSpacing()),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final character = widget.viewModel.characters[index];
        return Card(
          margin: EdgeInsets.only(bottom: responsivity.smallSpacing()),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: responsivity.responsiveBorderRadius(
                ResponsivityConstants.borderRadiusPercentage,
              ),
              child: Image.network(
                character.image,
                width: responsivity.listTileImageSize(),
                height: responsivity.listTileImageSize(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: responsivity.listTileImageSize()),
              ),
            ),
            title: Text(character.name, style: TextStyle(fontSize: responsivity.textSize())),
            subtitle: Text(
              character.species,
              style: TextStyle(fontSize: responsivity.textSize() * 0.9),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.characterDetails,
                arguments: {'character': character},
              );
            },
          ),
        );
      },
    );
  }
}
