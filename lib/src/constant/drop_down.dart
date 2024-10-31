// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_ecommerc/src/data/model/language.dart';
// import 'package:flutter_ecommerc/src/presentation/bloc/local/local_bloc.dart';
// import 'package:flutter_ecommerc/src/presentation/bloc/local/local_event.dart';
// import 'package:flutter_ecommerc/src/presentation/bloc/local/local_state.dart';

// class LanguageDropdown extends StatelessWidget {
//   final List<LanguageItem> languages = [
//     LanguageItem(code: 'en', name: 'English', locale: Locale('en')),
//     LanguageItem(code: 'es', name: 'Spanish', locale: Locale('es')),
//   ];

//   const LanguageDropdown({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LocalBloc, LocalState>(
//       builder: (context, state) {
//         LanguageItem? selectedLanguage = languages.firstWhere(
//           (lang) => lang.locale == state.locale,
//           orElse: () => languages.first,
//         );

//         return DropdownButton<LanguageItem>(
//           value: selectedLanguage,
//           items: languages.map((LanguageItem lang) {
//             return DropdownMenuItem<LanguageItem>(
//               value: lang,
//               child: Text(lang.name),
//             );
//           }).toList(),
//           onChanged: (LanguageItem? Locale) {
//             if (Locale != null) {
//               BlocProvider.of<Bloc>(context)
//                   .add(LocalChanged(locale: Locale.locale));
//             }
//           },
//         );
//       },
//     );
//   }
// }
