import 'package:flutter/material.dart';
import 'package:flutter_store/common/style/spacing_syles.dart';
import 'package:flutter_store/features/authentication/screens/login/widgets/login_form.dart';
import 'package:flutter_store/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/constants/text_strings.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title, & Sub-Title
              LoginHeader(),

              ///Form
              LoginForm(),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignInWith,),
              SizedBox(height: TSizes.spaceBtwSections,),
              /// Footer
              TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}








