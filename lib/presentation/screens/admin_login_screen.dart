import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/common/theme/app_colors.dart';
import 'package:pontodevenda/common/theme/app_text_styles.dart';
import 'package:pontodevenda/service/bloc/login/login_bloc.dart';
import 'package:pontodevenda/service/bloc/login/login_event.dart';
import 'package:pontodevenda/service/bloc/login/login_state.dart';
import 'admin_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  AdminLoginScreenState createState() => AdminLoginScreenState();
}

class AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'ÁREA DO ADMINISTRADOR',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 40),

                  // Campo Usuário
                  TextFormField(
                    controller: _usernameController,
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: 'Usuário',
                      labelStyle: const TextStyle(color: AppColors.subtitle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: 'Senha',
                      labelStyle: const TextStyle(color: AppColors.subtitle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Botão customizado manualmente
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is LoginLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                LoginSubmitted(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: AppTextStyles.button,
                          ),
                          child: state is LoginLoading
                              ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                              : const Text('Entrar'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
