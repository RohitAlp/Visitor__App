import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_localization/language/language_bloc.dart';
import 'config/Routes/Route.dart';
import 'config/Routes/RouteName.dart';
import 'database/DatabaseHelper.dart';
import 'l10n/app_localizations.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageBloc()..add(LanguageLoadStarted()),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          Locale locale = const Locale('en');
          if (state is LanguageLoaded) {
            locale = state.locale;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Visitor App',
            theme: ThemeData(
              colorScheme: .fromSeed(seedColor: Colors.deepPurple),
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryTextTheme: GoogleFonts.poppinsTextTheme(),
              scaffoldBackgroundColor: Colors.white,
          ),
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
            initialRoute: RouteName.splashScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}


