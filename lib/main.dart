import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ilacini_unutma/ui/cubit/anasayfa_cubit.dart';
import 'package:ilacini_unutma/ui/cubit/detay_sayfa_cubit.dart';
import 'package:ilacini_unutma/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:ilacini_unutma/ui/cubit/su_anasayfa_cubit.dart';
import 'package:ilacini_unutma/ui/cubit/su_kayit_sayfa_cubit.dart';
import 'package:ilacini_unutma/ui/views/anasayfa.dart';
import 'package:ilacini_unutma/ui/views/giris_sayfa.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:ilacini_unutma/Services/notifi_service.dart';
import 'package:ilacini_unutma/ui/views/kayit_sayfa.dart';

import 'package:ilacini_unutma/data/repo/sulardao_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sulardaoRepository = SulardaoRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KayitSayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => SuKayitSayfaCubit(sulardaoRepository)),
        BlocProvider(create: (context) => SuAnasayfaCubit(sulardaoRepository)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr', ''), // Turkish locale
        ],
        locale: const Locale('tr', ''),
        home: const GirisSayfa(),
      ),
    );
  }
}
