import 'package:birthmark/features/auth/presentation/pages/auth_page.dart';
import 'package:birthmark/features/wishes/presentation/widgets/wish_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../core/di/injector.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/wish_bloc.dart';
import '../bloc/wish_event.dart';
import '../bloc/wish_state.dart';
import '../widgets/wish_dialog.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector<WishBloc>()..add(LoadWishes()),
        child: Builder(builder: (context) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.secondaryLabel,
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      backgroundColor: CupertinoColors.secondaryLabel,
                      largeTitle: const Text('Wishes', style: TextStyle(color: CupertinoColors.inactiveGray, fontSize: 30, fontWeight: FontWeight.bold, decorationColor: CupertinoColors.systemMint, decoration: TextDecoration.lineThrough, decorationThickness: 1)),
                      trailing: CupertinoButton(
                        child: const Icon(CupertinoIcons.power, color: CupertinoColors.destructiveRed, size: 25),
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                          Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(builder: (_) => const AuthPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    BlocBuilder<WishBloc, WishState>(builder: (context, state) {
                      if (state is WishLoading) {
                        return const SliverToBoxAdapter(child: Center(child: CupertinoActivityIndicator()));
                      }
                      if (state is WishError) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: CupertinoColors.destructiveRed),
                            ),
                          ),
                        );
                      }
                      if (state is WishesLoaded) {
                        final wishes = state.wishes;
                        return SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) => WishTile(wish: wishes[index]), childCount: wishes.length));
                      }
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: GestureDetector(
                    onTap: () => _showAddDialog(context),
                    child: GlassContainer(
                      height: 56,
                      width: 56,
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
                      child: const Icon(CupertinoIcons.add, color: CupertinoColors.systemMint, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
  }      

  void _showAddDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (dialogContext) => WishDialog(
        onSave: (wish) {
          context.read<WishBloc>().add(AddWishEvent(wish));
          Navigator.pop(dialogContext);
        },
      ),
    );
  }
}