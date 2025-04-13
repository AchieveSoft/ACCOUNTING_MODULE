part of 'bloc.dart';

abstract class CommonScaffoldEvent {}

class CommonScaffoldSelectMenuEvent extends CommonScaffoldEvent {
  final String key;
  final String title;

  CommonScaffoldSelectMenuEvent({required this.key, required this.title});
}
