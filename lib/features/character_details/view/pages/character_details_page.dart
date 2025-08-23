import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/constants/responsivity_contants.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';
import 'package:rick_morthy_app/core/ui/states/app_load_widget.dart';
import 'package:rick_morthy_app/core/ui/states/flow_state_widget.dart';
import 'package:rick_morthy_app/core/utils/responsivity_utils.dart';
import 'package:rick_morthy_app/features/character_details/presentation/viewmodel/character_details_view_model.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterDetailsViewModel viewModel;

  const CharacterDetailsPage({super.key, required this.viewModel});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  late ResponsivityUtils responsivity;

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
    responsivity = ResponsivityUtils(context);
    _fetchArguments(context);

    return Scaffold(
      appBar: AppBar(
        title: widget.viewModel.character != null
            ? Text(
                widget.viewModel.character!.name,
                style: TextStyle(fontSize: responsivity.textSize() * 1.2),
              )
            : Text(
                'Detalhes do Personagem',
                style: TextStyle(fontSize: responsivity.textSize() * 1.2),
              ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.viewModel.isLoading) {
      return AppLoadWidget(
        label: 'Carregando personagem...',
        padding: responsivity.responsiveAllPadding(ResponsivityConstants.verticalPaddingPercentage),
      );
    }

    if (widget.viewModel.hasError || widget.viewModel.character == null) {
      return FlowStateWidget(
        title: 'Erro',
        description: widget.viewModel.error.isNotEmpty
            ? widget.viewModel.error
            : 'Personagem não disponível',
        flowState: FlowState.error,
        responsivity: responsivity,
      );
    }

    return _buildCharacterDetails();
  }

  Widget _buildCharacterDetails() {
    return SingleChildScrollView(
      padding: responsivity.responsivePadding(
        horizontalPercentage: ResponsivityConstants.horizontalPaddingPercentage,
        verticalPercentage: ResponsivityConstants.verticalPaddingPercentage,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: responsivity.responsiveBorderRadius(
                ResponsivityConstants.borderRadiusPercentage,
              ),
              child: Image.network(
                widget.viewModel.character!.image,
                width: responsivity.imageSize(),
                height: responsivity.imageSize(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: responsivity.largeSpacing()),
          _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: responsivity.responsiveAllPadding(ResponsivityConstants.defaultSpacingPercentage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nome', widget.viewModel.character!.name),
            SizedBox(height: responsivity.defaultSpacing()),
            _buildInfoRow('Status', widget.viewModel.character!.status),
            SizedBox(height: responsivity.defaultSpacing()),
            _buildInfoRow('Espécie', widget.viewModel.character!.species),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsivity.textSize()),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: responsivity.textSize())),
        ),
      ],
    );
  }
}
