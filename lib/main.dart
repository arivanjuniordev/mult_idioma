import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

void main() {
  runApp(const MyApp());
}

final local = ValueNotifier(const Locale('en', 'US'));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // set json file directory
    // default value is ['lib/i18n']
    // LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    //or set a map of translations
    // MapLocalization.delegate.translations = {
    //   const Locale('en', 'US'): {
    //     'welcome-text': 'This text is in english',
    //   },
    //   const Locale('es', 'ES'): {
    //     'welcome-text': 'Este texto esta en español',
    //   },
    //   const Locale('pt', 'BR'): {
    //     'welcome-text': 'Este texto está em português',
    //   },
    // };

    return ValueListenableBuilder(
        valueListenable: local,
        builder: (context, loc, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: [
              // delegate from flutter_localization
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,

              // delegate from localization package.
              //json-file
              LocalJsonLocalization.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'ES'),
              Locale('pt', 'BR'),
            ],
            locale: loc,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    local.value = const Locale('pt', 'BR');
  }

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'welcome-text'.i18n(),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
