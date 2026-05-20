import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
 
class AuthForm extends StatefulWidget {
  final String? errorMessage;
  const AuthForm({super.key, this.errorMessage});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _localError;
  final _retryPasswordController = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _retryPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final retryPassword = _retryPasswordController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      setState(() => _localError = 'Заполните все поля');
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _localError = null);
      });
      return;
    }
    if(!_isLogin && password != retryPassword) {
      setState(() => _localError = 'Пароли не совпадают');
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _localError = null);
      });
      return;
    }
    final bloc = context.read<AuthBloc>();
    if (_isLogin) {
      bloc.add(LoginEvent(username, password));
    } else {
      bloc.add(RegisterEvent(username, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayError = widget.errorMessage ?? _localError;
    return Padding(
      padding: EdgeInsets.only(top: 130, left: 20, right: 20, bottom: _isLogin ? 170 : 100),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CupertinoColors.quaternaryLabel,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(_isLogin ? "Вход" : "Регистрация", style: const TextStyle(color: CupertinoColors.secondaryLabel, fontSize: 30, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: CupertinoColors.systemMint, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2)),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding:EdgeInsetsGeometry.all(16),
              child: CupertinoTextField(
                padding: const EdgeInsets.all(16),
                controller: _usernameController,
                decoration: const BoxDecoration(
                  color: CupertinoColors.secondaryLabel,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                placeholder: "логин",
                placeholderStyle: TextStyle(color: CupertinoColors.systemMint.withOpacity(0.4)),
              ),
            ),
            Padding(
              padding:EdgeInsetsGeometry.all(16),
              child: CupertinoTextField(
                padding: const EdgeInsets.all(16),
                obscureText: true,
                controller: _passwordController,
                decoration: const BoxDecoration(
                  color: CupertinoColors.secondaryLabel,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                placeholder: "пароль",
                placeholderStyle: TextStyle(color: CupertinoColors.systemMint.withOpacity(0.4)),
              ),
            ),
            if(!_isLogin)
              Padding(
                padding:EdgeInsetsGeometry.all(16),
                child: CupertinoTextField(
                  padding: const EdgeInsets.all(16),
                  obscureText: true,
                  controller: _retryPasswordController,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.secondaryLabel,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  placeholder: "повторите пароль",
                  placeholderStyle: TextStyle(color: CupertinoColors.systemMint.withOpacity(0.4)),
                ),
              ),
            if (displayError != null && displayError.isNotEmpty)
              Text(
                displayError,
                style: const TextStyle(color: CupertinoColors.destructiveRed, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _submit,
              child: GlassContainer(
                height: 40,
                width: 300,
                isFrostedGlass: true,
                frostedOpacity: 0.05,
                blur: 20,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                 borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.60),
                    Colors.white.withValues(alpha: 0.0),
                    Colors.white.withValues(alpha: 0.0),
                    Colors.white.withValues(alpha: 0.60),
                  ],
                  stops: const [0.0, 0.45, 0.55, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                child: Center(
                  child: Text(
                    _isLogin ? 'Войти' : 'Зарегистрироваться',
                    style: const TextStyle(color: CupertinoColors.systemMint, fontSize: 18),
                  ),
                ),

              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(
            child: Text(
              _isLogin ? 'Создать аккаунт' : 'Уже есть аккаунт?',
              style: const TextStyle(color: CupertinoColors.secondaryLabel, decoration: TextDecoration.underline, decorationColor: CupertinoColors.systemMint, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
              _usernameController.clear();
              _passwordController.clear();
              _retryPasswordController.clear();
            },
          ),
          ],
        ),
      ),
    );
  }
}