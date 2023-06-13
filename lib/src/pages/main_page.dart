import 'package:flutter/material.dart';
import 'package:flutter_cep/src/services/postal_code_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/location_card.dart';
import '../components/app_message.dart';
import 'history_page.dart';

import 'package:provider/provider.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController postalCodeInputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final service = context.read<PostalCodeService>();
    
    service.addListener(() {
      if(service.state == LocationState.success){
        AppMessage(context, 'Sucesso', Colors.green);
      } else if(service.state == LocationState.error){
        AppMessage(context, 'Erro', Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PostalCodeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('CEP'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HistoryPage()
              )
            );
          },  icon: Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(//Faz o scroll
        padding: const EdgeInsets.symmetric(
          vertical: 25, horizontal: 15
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: postalCodeInputController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Informe o CEP',
                  labelText: 'CEP',
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'CEP obrigatório!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10
              ),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      
                      service.searchPostalCode(postalCode: postalCodeInputController.text);
                      postalCodeInputController.clear();
                    }
                  },
                  child: const Text('Buscar CEP')),
              const SizedBox(
                height: 30,
              ),
              LocationCard()
              //Quando houver um notifyListener, atualiza apenas o componente
              // Consumer<PostalCodeService>(
              //     builder: (context, postalcodeService, _){
              //       return Column(
              //         children: [
              //           Text('CEP: ${postalcodeService.lastLocationSearched.postalCode}'),
              //           Text('Logradouro: ${postalcodeService.lastLocationSearched.address}'),
              //           Text('Cidade: ${postalcodeService.lastLocationSearched.city}'),
              //           Text('Estado: ${postalcodeService.lastLocationSearched.state}')
              //         ],
              //       );
              //     }
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
