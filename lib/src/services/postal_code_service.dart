import 'package:flutter/cupertino.dart';
import 'package:flutter_cep/src/models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum LocationState { idle, success, error, loading }

class PostalCodeService extends ChangeNotifier {

  LocationState state = LocationState.idle;

  Location lastLocationSearched = Location(
    postalCode: '',
    address: '',
    city: '',
    state: ''
  );

  final List<Location> searchedList = [];

  Future<void> searchPostalCode({required String postalCode}) async{
    try{
      state = LocationState.loading;


      notifyListeners();

      String cepUrl = 'https://viacep.com.br/ws';
      String responseFormat = 'json';

      Uri cepUri = Uri.parse('$cepUrl/$postalCode/$responseFormat');

      //Final define o tipo de acordo com a atribuição
      final response = await http.get(cepUri);

      if(response.statusCode >= 400){
        state = LocationState.error;
      }

      var fullAddress = jsonDecode(response.body);

      lastLocationSearched = Location.fromJson(fullAddress);

      searchedList.add(lastLocationSearched);

      state = LocationState.success;

      notifyListeners();
    } catch (_) {
      state = LocationState.error;
      notifyListeners();
    }
  }
}
