import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_bloc.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_event.dart';
import 'package:birthmark/features/birthdate/presentation/widgets/birthdate_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                icon: CupertinoIcons.pencil,
              ),
              SlidableAction(
                onPressed: (context) => _deleteBirthdate(context, birthDate),
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 30, 171, 219).withOpacity(0.78),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 11),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(birthDate.name, style: TextStyle(fontSize: 16, )),
                        const SizedBox(height: 4),
                        Text(_formatDate(birthDate.birthDate), style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel),),
                      ],
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


    
