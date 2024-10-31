import 'package:flutter/material.dart';

abstract class LocalEvent {}

class LocalChanged extends LocalEvent {
  final Locale locale;
  LocalChanged({required this.locale});
}
