import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:quotes_app/views/auth_check.dart';
import 'package:quotes_app/views/themes/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    localStorage: const EmptyLocalStorage(),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      maximumSize: const Size(390, double.infinity),
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quotes App',
          themeMode: ThemeMode.light,
          darkTheme: MyTheme.darkTheme,
          theme: MyTheme.lightTheme,
          home: const AuthCheck(),
        );
      },
    );
  }
}
