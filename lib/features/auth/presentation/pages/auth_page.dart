import 'package:birthmark/features/auth/presentation/bloc/auth_event.dart';
import 'package:birthmark/features/wishes/presentation/pages/wish_list_page.dart';
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
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (_) => const WishListPage()),
            );
          }
          if (state is AuthError) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.read<AuthBloc>().add(ClearErrorEvent());
              }
            });
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return AuthForm(errorMessage: state is AuthError ? state.message : null);
        },
      ),
    );
  }
}