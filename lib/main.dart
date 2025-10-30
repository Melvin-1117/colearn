import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/presentation/auth_wrapper.dart';

const String supabaseUrl = 'https://rdzaigimmnvbsksvatw.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkemFpZ2ltbnZic2tzdmxhdGt3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwODc1NDMsImV4cCI6MjA3NTY2MzU0M30.ZJEsFMQkAcJMZjY9HPWcl_urgLZVqiYZRrq-fIhrJ3c';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase client
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace the old FutureBuilder with a direct return since init is in main()
    return const ProviderScope(child: MyApp());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colearn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthWrapper(),
    );
  }
}
