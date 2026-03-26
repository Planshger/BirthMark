import 'package:birthmark/features/onboarding/domain/usecases/get_onboarding_items.dart';
import 'package:birthmark/features/onboarding/domain/usecases/is_onboarding_completed.dart';
import 'package:birthmark/features/onboarding/domain/usecases/mark_onboarding_completed.dart';
import 'package:birthmark/features/onboarding/presentation/bloc/onboardig_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingItems getOnboardingItems;
  final IsOnboardingCompleted isCompleted;
  final MarkOnboardingCompleted markCompleted;

  OnboardingBloc({
    required this.getOnboardingItems,
    required this.isCompleted,
    required this.markCompleted,
  }) : super(OnboardingInitial()) {
    on<LoadOnboarding>(_onLoad);
    on<NextPage>(_onNext);
    on<PreviousPage>(_onPrevious);
    on<CompleteOnboarding>(_onComplete);
    on<SilentPageUpdate>(_onSilentPageUpdate);
  }

  Future<void> _onLoad(LoadOnboarding event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoading());
    try {
      final done = await isCompleted();
      final items = await getOnboardingItems();
      if (done) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingLoaded(items, 0));
      }
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  void _onNext(NextPage event, Emitter<OnboardingState> emit) {
    if (state is OnboardingLoaded) {
      final current = state as OnboardingLoaded;
      final nextIndex = (current.currentIndex + 1).clamp(0, current.items.length - 1);
      emit(OnboardingLoaded(current.items, nextIndex));
    }
  }

  void _onPrevious(PreviousPage event, Emitter<OnboardingState> emit) {
    if (state is OnboardingLoaded) {
      final current = state as OnboardingLoaded;
      final prevIndex = (current.currentIndex - 1).clamp(0, current.items.length - 1);
      emit(OnboardingLoaded(current.items, prevIndex));
    }
  }

  void _onSilentPageUpdate(SilentPageUpdate event, Emitter<OnboardingState> emit) {
    if (state is OnboardingLoaded) {
      final current = state as OnboardingLoaded;
      emit(OnboardingLoaded(current.items, event.index));
    }
  }

  Future<void> _onComplete(CompleteOnboarding event, Emitter<OnboardingState> emit) async {
    await markCompleted();
    emit(OnboardingCompleted());
  }
}
