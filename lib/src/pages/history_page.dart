import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/postal_code_service.dart';
import '../models/location.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final service = context.watch<PostalCodeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de pesquisa'),
        centerTitle: true,
      ),
      body: service.searchedList.isEmpty ?
          const Text('Nenhuma consulta realizada') : 
          ListView.builder(
            shrinkWrap: true,
              itemCount: service.searchedList.length,
              itemBuilder: (context, index){
                Location location = service.searchedList[index];
                return ListTile(
                  title: Text('${location.city}/${location.state}'),
                  subtitle: Text('${location.address} - ${location.postalCode}'),
                  leading: Icon(Icons.food_bank_rounded),
                  trailing: Icon(Icons.restore_from_trash),
                );
              }
          )
    );
  }
}
