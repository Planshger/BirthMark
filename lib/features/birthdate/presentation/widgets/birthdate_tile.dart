import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_bloc.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_event.dart';
import 'package:birthmark/features/birthdate/presentation/widgets/birthdate_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glass_kit/glass_kit.dart';

class BirthdateTile extends StatelessWidget {
  final BirthDate birthDate;

  const BirthdateTile({super.key, required this.birthDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0), 
      child: SizedBox(
        height: 80,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => _editBirthdate(context, birthDate),
                backgroundColor: Colors.transparent,
                icon: CupertinoIcons.pencil,
              ),
              SlidableAction(
                onPressed: (context) => _deleteBirthdate(context, birthDate),
                backgroundColor: Colors.transparent,
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
          child: GlassContainer(
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
              stops: [0.0, 0.45, 0.55, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 20.0)
            ],
            borderRadius: BorderRadius.circular(25.0),
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(birthDate.name, style: TextStyle(fontSize: 16, color: CupertinoColors.systemCyan)),
                      const SizedBox(height: 4),
                      Text(_formatDate(birthDate.birthDate), style: const TextStyle(fontSize: 14, color: CupertinoColors.opaqueSeparator),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  void _deleteBirthdate(BuildContext context, BirthDate birthDate) {
    final bloc = context.read<BirthdateBloc>();
    bloc.add(DeleteBirthDateEvent(id: birthDate.id));
  }

  void _editBirthdate(BuildContext context, BirthDate birthDate) {
    final bloc = context.read<BirthdateBloc>();
    showCupertinoModalPopup(
      context: context, 
      builder: (context) {
        return BirthdateDialog(
          initialName: birthDate.name,
          initialBirthdate: birthDate.birthDate,
          onSave: (name, newBirthDate) {
            bloc.add(UpdateBirthDateEvent(birthDate: birthDate.copyWith(name: name, birthDate: newBirthDate)));
          },
        );
      }
    );
    }
  }


    
