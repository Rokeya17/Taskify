import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/showcase/screens/authentication/sign_in_screen.dart';
import 'package:taskmanager/ui/showcase/widgets/screen_background.dart';
import 'package:taskmanager/ui/ui_components/form_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _signUpInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  //final TextEditingController _emailTEController = TextEditingController();+

  Future<void> _userSignUp() async {
    _signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": ""
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please correct the errors in the form.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SingleChildScrollView(
            //padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Join With Us",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 36,
                            letterSpacing: 0.6),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          validator: FormValidator.validateEmail),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                        validator: FormValidator.validateName,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                        validator: FormValidator.validateName,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Mobile",
                        ),
                        validator: FormValidator.validateMobileNumber,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                          controller: _passwordTEController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: _passwordVisible
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: FormValidator.validPasswordSignUp),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _signUpInProgress == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _userSignUp();
                              },
                              child: const Icon(Icons.arrow_forward_ios)),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.3),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text("Sign In"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
