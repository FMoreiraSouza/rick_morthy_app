import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/constants/responsivity_contants.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';
import 'package:rick_morthy_app/core/utils/responsivity_utils.dart';

class FlowStateWidget extends StatelessWidget {
  const FlowStateWidget({
    super.key,
    this.function,
    required this.title,
    required this.description,
    this.hideButton = false,
    required this.flowState,
    required this.responsivity,
  });

  final Function? function;
  final String title;
  final String description;
  final bool hideButton;
  final FlowState flowState;
  final ResponsivityUtils responsivity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: responsivity.responsiveAllPadding(
          ResponsivityConstants.horizontalPaddingPercentage,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _getIcon(flowState),
              size: responsivity.iconSize(),
              color: _getIconColor(flowState, context),
            ),
            SizedBox(height: responsivity.defaultSpacing()),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: responsivity.textSize() * 1.3),
            ),
            SizedBox(height: responsivity.smallSpacing()),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: responsivity.textSize()),
            ),
            SizedBox(height: responsivity.defaultSpacing()),
            Visibility(
              visible: !hideButton,
              child: ElevatedButton(
                onPressed: () {
                  if (function != null) {
                    function!();
                  }
                },
                child: Text(
                  'Tentar Novamente',
                  style: TextStyle(fontSize: responsivity.textSize()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(FlowState flowState) {
    switch (flowState) {
      case FlowState.error:
        return Icons.error_outline;
      case FlowState.empty:
        return Icons.inbox_outlined;
      case FlowState.noConnection:
        return Icons.wifi_off_outlined;
      case FlowState.warning:
        return Icons.warning_amber_outlined;
    }
  }

  Color _getIconColor(FlowState flowState, BuildContext context) {
    final theme = Theme.of(context);
    switch (flowState) {
      case FlowState.error:
        return theme.colorScheme.error;
      case FlowState.empty:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6);
      case FlowState.noConnection:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6);
      case FlowState.warning:
        return theme.colorScheme.secondary;
    }
  }
}
