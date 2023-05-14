import 'package:deliverzler/auth/domain/use_cases/sign_in_with_email_uc.dart';
import 'package:deliverzler/auth/presentation/components/login_text_fields_section.dart';
import 'package:deliverzler/auth/presentation/providers/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:deliverzler/core/presentation/helpers/localization_helper.dart';
import 'package:deliverzler/core/presentation/styles/sizes.dart';
import 'package:deliverzler/core/presentation/widgets/custom_button.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginFormComponent extends HookConsumerWidget {
  const LoginFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    final signIn = useCallback(() {
      final bool canSubmit = !ref.read(signInStateProvider).isLoading;

      if (canSubmit && loginFormKey.currentState!.validate()) {
        final params = SignInWithEmailParams(
          email: emailController.text,
          password: passwordController.text,
        );
        ref.read(signInWithEmailParamsProvider.notifier).state = Some(params);
      }
    }, []);

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          LoginTextFieldsSection(
            emailController: emailController,
            passwordController: passwordController,
            onFieldSubmitted: (value) {
              signIn();
            },
          ),
          SizedBox(
            height: Sizes.marginV40(context),
          ),
          CustomButton(
            text: tr(context).signIn,
            onPressed: signIn,
          ),
        ],
      ),
    );
  }
}
