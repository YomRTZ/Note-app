import 'package:flutter_ecommerc/src/data/domain/login_repository.dart';
import 'package:flutter_ecommerc/src/data/domain/map_repository.dart';
import 'package:flutter_ecommerc/src/data/domain/post_repository.dart';
import 'package:flutter_ecommerc/src/data/provider/login_provider.dart';
import 'package:flutter_ecommerc/src/data/provider/map_provider.dart';
import 'package:flutter_ecommerc/src/data/provider/post_provider.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_state.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/pages/login.dart';
// import 'package:flutter_ecommerc/src/presentation/pages/view_post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // Bloc.observer = AppBlocObserver();
  //  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LoginRepository loginRepository =
      LoginRepository(loginProvider: LoginProvider());
  final PostRepository postRepository =
      PostRepository(postProvider: PostProvider());
final MapRepository mapRepository =
      MapRepository(mapProvider: MapProvider());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(loginRepository: loginRepository)),
        BlocProvider<PostBloc>(
            create: (context) => PostBloc(postRepository: postRepository)),
            BlocProvider<MapBloc>(
            create: (context) => MapBloc(mapRepository: mapRepository)),
        BlocProvider<LocalBloc>(create: (_) => LocalBloc())
      ],
      child: BlocBuilder<LocalBloc, LocalState>(builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('am', ''), // amharic
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginScreen(),
        );
      }),
    );
  }
}
