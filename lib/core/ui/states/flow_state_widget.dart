import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/enums/flow_state.dart';

class FlowStateWidget extends StatelessWidget {
  const FlowStateWidget({
    super.key,
    this.function,
    required this.title,
    required this.description,
    this.hideButton = false,
    required this.flowState,
  });

  final Function? function;
  final String title;
  final String description;
  final bool hideButton;
  final FlowState flowState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(_getIcon(flowState), size: 64, color: _getIconColor(flowState, context)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: !hideButton,
              child: ElevatedButton(
                onPressed: () {
                  if (function != null) {
                    function!();
                  }
                },
                child: const Text('Tentar Novamente'),
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
