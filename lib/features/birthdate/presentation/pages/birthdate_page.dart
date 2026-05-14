import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/core/widgets/action_button.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_bloc.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_event.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_state.dart';
import 'package:birthmark/features/birthdate/presentation/widgets/birthdate_dialog.dart';
import 'package:birthmark/features/birthdate/presentation/widgets/birthdate_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BirthDatePage extends StatefulWidget{

  const BirthDatePage({super.key});

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<BirthdateBloc>()..add(LoadBirthDatesEvent()),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.secondaryLabel,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  backgroundColor: CupertinoColors.secondaryLabel,
                  largeTitle: Text('BirthMark', style: TextStyle(color: CupertinoColors.opaqueSeparator), ),
                ),
                BlocBuilder<BirthdateBloc, BirthdateState>(
                  builder: (context, state) {
                    if (state is BirthdateError) {
                      return SliverFillRemaining(
                          child: Center(child: Text(state.error)));
                    }
                    if (state is! BirthdateLoaded) {
                      return const SliverFillRemaining(
                          child: Center(child: CupertinoActivityIndicator()));
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return BirthdateTile(
                            birthDate: state.birthdates[index],
                          );
                        },
                        childCount: state.birthdates.length,
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: Builder(builder: (context) {
                return ActionButton(
                    icon: CupertinoIcons.add,
                    onPressed: () => _createBirthdate(context));
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _createBirthdate(BuildContext context)  {
    final bloc = context.read<BirthdateBloc>();

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return BirthdateDialog(
          onSave: (name, birthDate) {
            bloc.add(AddBirthDateEvent(name: name, birthDate: birthDate));
          },
        );
      },
    ); 
  }
}