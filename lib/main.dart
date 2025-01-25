import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:missing/Pages/splash.dart';
import 'package:missing/bloc/bloc_state.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';

//flutter run -d chrome --web-renderer html
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => MyCubit()..loadLanguage(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCubit, BlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        MyCubit cubit = MyCubit.get(context);

        String language = cubit.language.isNotEmpty ? cubit.language : 'en';

        return MaterialApp(
          title: "Missing",
          locale: Locale(language),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Splach(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
