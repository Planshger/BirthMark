import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/usecases/add_birthdate.dart';
import 'package:birthmark/features/birthdate/domain/usecases/delete_birthdate.dart';
import 'package:birthmark/features/birthdate/domain/usecases/get_birthdates.dart';
import 'package:birthmark/features/birthdate/domain/usecases/update_birthdate.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_event.dart';
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BirthdateBloc extends Bloc<BirthdateEvent, BirthdateState> {
  final GetBirthDates getBirthDates;
  final AddBirthDate addBirthDate;
  final DeleteBirthDate deleteBirthDate;
  final UpdateBirthDate updateBirthDate;

  List<BirthDate> birthdates = [];

  BirthdateBloc({
    required this.addBirthDate, 
    required this.deleteBirthDate, 
    required this.getBirthDates, 
    required this.updateBirthDate
    }) : super(BirthdateInitial()) {
    on<LoadBirthDatesEvent>(_onLoad);
    on<AddBirthDateEvent>(_onAdd);
    on<DeleteBirthDateEvent>(_onDelete);
    on<UpdateBirthDateEvent>(_onUpdate);
  }

  Future<void> _onLoad(LoadBirthDatesEvent event, Emitter<BirthdateState> emit) async {
    emit(BirthdateLoading());
    try {
      birthdates = await getBirthDates();
      emit(BirthdateLoaded(birthdates));
    } catch (e) { emit(BirthdateError(e.toString()));}
  }

  Future<void> _onAdd(AddBirthDateEvent event, Emitter<BirthdateState> emit) async {
    try {
      await addBirthDate(BirthDate(name: event.name, birthDate: event.birthDate, gift: event.gift));
      add(LoadBirthDatesEvent());
    } catch (e) { emit(BirthdateError(e.toString()));}
  }

  Future<void> _onUpdate(UpdateBirthDateEvent event, Emitter<BirthdateState> emit) async {
    try {
      await updateBirthDate(event.birthDate);
      add(LoadBirthDatesEvent());
    } catch (e) { emit(BirthdateError(e.toString()));} 
  }

  Future<void> _onDelete(DeleteBirthDateEvent event, Emitter<BirthdateState> emit) async {
    try {
      await deleteBirthDate(event.id);
      add(LoadBirthDatesEvent());
    } catch (e) { emit(BirthdateError(e.toString()));}
  }

}