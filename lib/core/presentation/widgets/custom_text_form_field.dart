import 'package:deliverzler/core/presentation/helpers/platform_helper.dart';
import 'package:deliverzler/core/presentation/styles/font_styles.dart';
import 'package:deliverzler/core/presentation/styles/sizes.dart';
import 'package:deliverzler/core/presentation/widgets/platform_widgets/platform_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.initialValue,
    this.controller,
    this.validator,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.enabled,
    this.contentPadding,
    this.hintText,
    this.materialPrefix,
    this.cupertinoPrefix,
    this.suffix,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.errorMaxLines,
  }) : super(key: key);

  final String? initialValue;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool? enabled;
  final EdgeInsets? contentPadding;
  final String? hintText;
  final Widget? materialPrefix;
  final Widget? cupertinoPrefix;
  final Widget? suffix;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PlatformTextFormField(
          initialValue: initialValue,
          controller: controller,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          maxLength: maxLength,
          maxLines: minLines,
          minLines: minLines,
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1?.color,
            fontSize: Sizes.font16(context),
            fontFamily: FontStyles.fontFamily(context),
          ),
          cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
          materialData: MaterialTextFormFieldData(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: Sizes.textFieldPaddingV16(context),
                    horizontal: Sizes.textFieldPaddingH16(context),
                  ),
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: Sizes.font14(context),
                fontFamily: FontStyles.fontFamily(context),
                color: Theme.of(context).hintColor,
              ),
              prefixIcon: materialPrefix,
              prefixIconColor:
                  Theme.of(context).inputDecorationTheme.prefixIconColor,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              suffixIcon: suffix != null
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: Sizes.paddingH16(context),
                      ),
                      child: suffix,
                    )
                  : null,
              suffixIconColor:
                  Theme.of(context).inputDecorationTheme.suffixIconColor,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              errorStyle: TextStyle(
                color: Theme.of(context).inputDecorationTheme.errorStyle?.color,
                fontWeight: FontStyles.fontWeightNormal,
                fontSize: Sizes.font12(context),
                fontFamily: FontStyles.fontFamily(context),
              ),
              errorMaxLines: errorMaxLines,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.textFieldRadius12(context)),
                ),
                borderSide:
                    Theme.of(context).inputDecorationTheme.border!.borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.textFieldRadius12(context)),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .enabledBorder!
                    .borderSide,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.textFieldRadius12(context)),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .focusedBorder!
                    .borderSide,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.textFieldRadius12(context)),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .errorBorder!
                    .borderSide,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.textFieldRadius12(context)),
                ),
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .errorBorder!
                    .borderSide,
              ),
            ),
          ),
          cupertinoData: CupertinoFormRowData(
            padding: contentPadding ??
                EdgeInsetsDirectional.only(
                  top: Sizes.textFieldPaddingV12(context),
                  bottom: Sizes.textFieldPaddingV12(context),
                  end: suffix != null ? Sizes.paddingH40(context) : 0.0,
                ),
            placeHolder: hintText,
            placeholderStyle: TextStyle(
              fontSize: Sizes.font14(context),
              fontFamily: FontStyles.fontFamily(context),
              color: Theme.of(context).hintColor,
            ),
            prefix: cupertinoPrefix,
          ),
        ),
        //Add suffix manually for iOS https://github.com/flutter/flutter/issues/103385
        if (suffix != null && !PlatformHelper.isMaterialApp())
          PositionedDirectional(
            top: (contentPadding?.top ?? Sizes.textFieldPaddingV12(context)) *
                1.5,
            end: Sizes.paddingH16(context),
            child: suffix!,
          ),
      ],
    );
  }
}
