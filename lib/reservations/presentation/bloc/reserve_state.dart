part of 'reserve_bloc.dart';


@immutable
abstract class ReservesState {}

class ReservesInitial extends ReservesState {}

class AuthFailureState extends ReservesState {
  final String message;

  AuthFailureState({required this.message});
}

class NoInternetConnection extends ReservesState {}

class ReservesLoading extends ReservesState {}

class GetReservesSuccess extends ReservesState {
  final List<ReservationModel> resultList;

  GetReservesSuccess({required this.resultList});
}

class ReservesSuccessState extends ReservesState {
  final String message;

  ReservesSuccessState({required this.message});
}

class ReservesFailureState extends ReservesState {
  final String message;

  ReservesFailureState({required this.message});
}
