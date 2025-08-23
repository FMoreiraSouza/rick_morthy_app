import 'package:flutter/material.dart';
import 'package:rick_morthy_app/core/constants/responsivity_contants.dart';
import 'package:rick_morthy_app/core/utils/responsivity_utils.dart';

class AppLoadWidget extends StatelessWidget {
  final String? label;
  final Color? bgColor;
  final Color? textColor;
  final EdgeInsets? padding;

  const AppLoadWidget({super.key, this.label, this.bgColor, this.textColor, this.padding});

  @override
  Widget build(BuildContext context) {
    final responsivity = ResponsivityUtils(context);

    return Container(
      color: bgColor ?? Colors.transparent,
      child: Padding(
        padding:
            padding ??
            responsivity.responsiveAllPadding(ResponsivityConstants.verticalPaddingPercentage),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              if (label != null) ...[
                SizedBox(height: responsivity.defaultSpacing()),
                Text(
                  label!,
                  style: TextStyle(
                    color: textColor ?? Theme.of(context).colorScheme.onSurface,
                    fontSize: responsivity.textSize(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
