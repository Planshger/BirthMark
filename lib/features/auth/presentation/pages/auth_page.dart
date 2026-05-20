import 'package:birthmark/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CupertinoColors.placeholderText,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.read<AuthBloc>().add(ClearErrorEvent());
              }
            });
          }
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => const _WelcomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is AuthError) {
            return  AuthForm(errorMessage: state.message);
          }
          return const AuthForm();
        },
      ),
    );
  }
}

class _WelcomeScreen extends StatelessWidget {
  const _WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(color: CupertinoColors.label, fontSize: 24),
            ),
            const SizedBox(height: 30),
            CupertinoButton(
              color: CupertinoColors.destructiveRed,
              child: const Text('Выйти'),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (_) => const AuthPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}