
class Location {
  String postalCode;
  String address;
  String city;
  String state;

  Location({
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state
  });

  factory Location.fromJson(Map<String, dynamic> jsonData){
    return Location(
        postalCode: jsonData['cep'],
        address: jsonData['logradouro'],
        city: jsonData['localidade'],
        state: jsonData['uf']);
  }
}