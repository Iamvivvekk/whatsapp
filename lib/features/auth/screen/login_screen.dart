import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/widgets/custom_button.dart';
import 'package:whatsapp/core/common/widgets/custom_height.dart';
import 'package:whatsapp/core/common/widgets/custom_width.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/core/utils/country_picker.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  Country? _country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    countrypicker(
        context: context,
        onSelect: (country) {
          setState(() {
            _country = country;
          });
        });
  }

  void navigateToOtpScreen() {
    String phoneNumber = phoneController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhoneNumber(
            context,
            "+${_country!.phoneCode}$phoneNumber",
          );
    } else {
      showSnackbar(context, "*All fields are mandatory");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const VerticalSpacer(),
              Text(
                "Enter your phone number",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const VerticalSpacer(),
              Text(
                "WhatsApp will need to verify your phone number. Carrier charges may apply.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const VerticalSpacer(height: 10),
              TextButton(
                  onPressed: pickCountry, child: const Text("pick country")),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_country != null)
                    Text(
                      "${_country!.flagEmoji}  + ${_country!.phoneCode}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const HorizontalSpacer(width: 10),
                  SizedBox(
                    width: size.width * 0.65,
                    child: TextField(
                      controller: phoneController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "phone number",
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 120,
                child: CustomElevatedButton(
                  btnText: "Next",
                  onTap: navigateToOtpScreen,
                ),
              ),
              const VerticalSpacer()
            ],
          ),
        ),
      ),
    );
  }
}
