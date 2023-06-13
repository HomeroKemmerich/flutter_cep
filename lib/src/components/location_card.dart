import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/postal_code_service.dart';

///Não é necessário controlar o estado
class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final postalCodeService = context.watch<PostalCodeService>();

    return postalCodeService.state == LocationState.idle ?
        Container() :
        (
            postalCodeService.state ==  LocationState.loading ?
              const CircularProgressIndicator() : (
                postalCodeService.state == LocationState.error ?
                  const Text('Localidade não encontrada'):
                  Column(
                    children: [
                      Text('CEP: ${postalCodeService.lastLocationSearched.postalCode}'),
                      Text('Logradouro: ${postalCodeService.lastLocationSearched.address}'),
                      Text('Cidade: ${postalCodeService.lastLocationSearched.city}'),
                      Text('Estado: ${postalCodeService.lastLocationSearched.state}')
                    ],
                  )
        ));
  }
}
