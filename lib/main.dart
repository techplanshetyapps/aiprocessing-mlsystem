import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aiprocessing_mlsystem/l10n/app_localizations.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HouseholdAgendaApp());
}

class HouseholdAgendaApp extends StatelessWidget {
  const HouseholdAgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام أجندة المهام اليومية',
      debugShowCheckedModeBanner: false,
      
      // إعدادات الترجمة واللغات
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // العربية
        Locale('en', ''), // الإنجليزية
      ],
      locale: const Locale('ar', ''),
      
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B365D),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A7BB0),
          brightness: Brightness.dark,
        ),
      ),
      
      home: const HomeScreen(),
    );
  }
}