import 'package:flutter/material.dart';


import 'package:flutter_cep/src/pages/main_page.dart';
import 'package:flutter_cep/src/services/postal_code_service.dart';
import 'package:provider/provider.dart';

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PostalCodeService()//O serviço precisa extender o ChangeNotifier para que isso funcione
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App CEP',
        home: const MainPage(),
        theme: ThemeData(
            primarySwatch: Colors.teal
        ),
      )
    );
  }
}
