import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // FocusNode confirmFocusNode = FocusNode();

  bool isObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FormBuilderTextField(
                    name: 'full_name',
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'confirm_password',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon:  const Icon(Icons.check, color: Colors.green),
                    ),
                    obscureText: true,
                    validator: (value) => 'No coinciden'
                  ),
                  const SizedBox(height: 10),
                  FormBuilderFieldDecoration<bool>(
                    name: 'test',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.equal(true),
                    ]),
                    // initialValue: true,
                    decoration: const InputDecoration(labelText: 'Accept Terms?'),
                    builder: (FormFieldState<bool?> field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          errorText: field.errorText,
                        ),
                        child: SwitchListTile(
                          title: const Text(
                              'I have read and accept the terms of service.'),
                          onChanged: field.didChange,
                          value: field.value ?? false,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: _formKey.currentState?.validate() ?? false
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration Complete!'),
                        ),
                      );
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    }
                        : null,
                    style: const ButtonStyle().copyWith(
                      backgroundColor: MaterialStateProperty.all(
                        _formKey.currentState?.validate() ?? false
                            ? null
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}