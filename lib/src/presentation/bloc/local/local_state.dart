import 'package:flutter/material.dart';

abstract class LocalState {
  final Locale locale;
  LocalState({required this.locale});
}

class LocalStateInitial extends LocalState {
 LocalStateInitial() : super(locale: Locale('en', ''));
}

class LocalUpdate extends LocalState{
  LocalUpdate(Locale locale):super(locale: locale);
}