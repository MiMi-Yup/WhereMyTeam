part of 'team_cubit.dart';

@immutable
class TeamState extends Equatable {
  final Map<String, StreamSubscription> streamSubscription;
  const TeamState({required this.streamSubscription});

  factory TeamState.initial() => const TeamState(streamSubscription: {});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [streamSubscription];

  TeamState copyWith({Map<String, StreamSubscription>? streamSubscription}) =>
      TeamState(
          streamSubscription: streamSubscription ?? this.streamSubscription);
}
