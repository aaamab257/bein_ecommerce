part of 'local_cubit.dart';

@immutable
abstract class LocaleState extends Equatable {
  final Locale local;
  const LocaleState(this.local);
}

class ChangeLocaleState extends LocaleState {
  const ChangeLocaleState(super.local);

  @override
  List<Object?> get props =>[];
}

class ChangeLocaleStateLoading extends LocaleState {
  const ChangeLocaleStateLoading(super.local);

  @override
  List<Object?> get props =>[];
}
