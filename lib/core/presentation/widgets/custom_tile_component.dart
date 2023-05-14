import 'package:deliverzler/core/core_features/theme/presentation/utils/colors/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/presentation/styles/sizes.dart';
import 'package:deliverzler/core/presentation/widgets/custom_text.dart';

class CustomTileComponent extends StatelessWidget {
  const CustomTileComponent({
    required this.title,
    this.leadingIcon,
    this.leadingIconColor,
    this.customLeading,
    this.trailingText,
    this.customTrailing,
    this.onTap,
    this.contentPadding,
    Key? key,
  })  : assert((trailingText == null || customTrailing == null) &&
            (leadingIcon == null || customLeading == null)),
        super(key: key);

  final String title;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final Widget? customLeading;
  final String? trailingText;
  final Widget? customTrailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        dense: true,
        contentPadding: contentPadding,
        minLeadingWidth: 0.0,
        horizontalTitleGap: Sizes.marginH10(context),
        title: CustomText.f18(
          context,
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: customLeading ??
            (leadingIcon != null
                ? Icon(
                    leadingIcon,
                    size: Sizes.icon18(context),
                    color:
                        leadingIconColor ?? customColors(context).font17Color,
                  )
                : null),
        trailing: customTrailing ??
            (trailingText != null
                ? FittedBox(
                    child: CustomText.f14(
                      context,
                      trailingText!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : null),
        onTap: onTap,
      ),
    );
  }
}
