import 'package:deliverzler/core/presentation/widgets/platform_widgets/platform_text_button.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/presentation/styles/sizes.dart';
import 'package:deliverzler/core/presentation/widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final double minHeight;
  final double minWidth;
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final MaterialTapTargetSize? tapTargetSize;

  const CustomTextButton({
    this.minHeight = 0,
    this.minWidth = 0,
    this.child,
    this.text,
    required this.onPressed,
    this.shape,
    this.elevation,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.padding,
    this.onLongPress,
    this.tapTargetSize,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      onPressed: onPressed,
      materialData: MaterialTextButtonData(
        onLongPress: onLongPress,
        style: TextButton.styleFrom(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: Sizes.paddingV6(context),
                horizontal: Sizes.paddingH10(context),
              ),
          shape: shape,
          elevation: elevation ?? 0,
          backgroundColor: buttonColor,
          foregroundColor: splashColor ?? Theme.of(context).colorScheme.primary,
          shadowColor: shadowColor,
          minimumSize: Size(minWidth, minHeight),
          tapTargetSize: tapTargetSize,
        ),
      ),
      cupertinoData: CupertinoTextButtonData(
        color: buttonColor,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: Sizes.paddingV6(context),
              horizontal: Sizes.paddingH10(context),
            ),
        borderRadius: shape != null
            ? (shape as RoundedRectangleBorder)
                .borderRadius
                .resolve(Directionality.maybeOf(context))
            : null,
        minSize: minHeight,
      ),
      child: child ??
          CustomText.f14(
            context,
            text!,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
          ),
    );
  }
}
