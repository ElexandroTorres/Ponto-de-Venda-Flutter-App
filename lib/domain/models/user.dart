class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String firstName;
  final String lastName;
  final Address address;
  final Geolocation geolocation;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.geolocation,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      address: Address.fromJson(json['address']),
      geolocation: Geolocation.fromJson(json['address']['geolocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'name': {'firstname': firstName, 'lastname': lastName},
      'address': address.toJson(),
    };
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(lat: json['lat'], long: json['long']);
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }
}
