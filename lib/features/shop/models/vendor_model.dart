import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String? phoneNumber;
  Address? address;
  String profilePicture;
  String storeName;
  String thumbnail;
  String description;
  Address? storeAddress;
  String storePhoneNumber;
  String icon;
  String status;
  DateTime createdDate;
  DateTime modifiedDate;
  bool? isFeatured;

  VendorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
    required this.storeName,
    required this.thumbnail,
    required this.description,
    required this.storePhoneNumber,
    required this.icon,
    required this.status,
    required this.createdDate,
    required this.modifiedDate,
    this.phoneNumber,
    this.address,
    this.storeAddress,
    this.isFeatured,
  });

  /// Empty VendorModel
  static VendorModel empty() => VendorModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    profilePicture: '',
    storeName: '',
    thumbnail: '',
    description: '',
    storePhoneNumber: '',
    icon: '',
    status: '',
    createdDate: DateTime.now(),
    modifiedDate: DateTime.now(),
  );
  toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Address': address != null ? address!.toJson() : {},
      'ProfilePicture': profilePicture,
      'StoreName': storeName,
      'Thumbnail': thumbnail,
      'Description': description,
      'StoreAddress': storeAddress != null ? storeAddress!.toJson() : {},
      'StorePhoneNumber': storePhoneNumber,
      'Icon': icon,
      'Status': status,
      'CreatedDate': createdDate.toIso8601String(),
      'ModifiedDate': modifiedDate.toIso8601String(),
      'IsFeatured': isFeatured
    };
  }
  factory VendorModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return VendorModel.empty();
    return VendorModel(
        id: data['Id'],
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'],
        address: data['Address'] != null ? Address.fromJson(data['Address']) : null,
        profilePicture: data['ProfilePicture'] ?? '',
        storeName: data['StoreName'] ?? '',
        thumbnail: data['Thumbnail'] ?? '',
        description: data['Description'] ?? '',
        storeAddress: data['StoreAddress'] != null ? Address.fromJson(data['StoreAddress']) : null,
        storePhoneNumber: data['StorePhoneNumber'] ?? '',
        icon: data['Icon'] ?? '',
        status: data['Status'] ?? '',
        createdDate: DateTime.parse(data['CreatedDate']),
        modifiedDate: DateTime.parse(data['ModifiedDate']),
        isFeatured: data['IsFeatured'] ?? false
    );
  }

  /// Create VendorModel from Firestore snapshot
  factory VendorModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return VendorModel.empty();
    return VendorModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'],
      address: data['Address'] != null ? Address.fromJson(data['Address']) : null,
      profilePicture: data['ProfilePicture'] ?? '',
      storeName: data['StoreName'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      storeAddress: data['StoreAddress'] != null ? Address.fromJson(data['StoreAddress']) : null,
      storePhoneNumber: data['StorePhoneNumber'] ?? '',
      icon: data['Icon'] ?? '',
      status: data['Status'] ?? '',
      createdDate: DateTime.parse(data['CreatedDate']),
      modifiedDate: DateTime.parse(data['ModifiedDate']),
        isFeatured: data['IsFeatured'] ?? false
    );
  }

  /// Create VendorModel from Firestore query snapshot
 /* factory VendorModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return VendorModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'],
      address: data['Address'] != null ? Address.fromJson(data['Address']) : null,
      profilePicture: data['ProfilePicture'] ?? '',
      storeName: data['StoreName'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      storeAddress: data['StoreAddress'] != null ? Address.fromJson(data['StoreAddress']) : null,
      storePhoneNumber: data['StorePhoneNumber'] ?? '',
      icon: data['Icon'] ?? '',
      status: data['Status'] ?? '',
      createdDate: DateTime.parse(data['CreatedDate']),
      modifiedDate: DateTime.parse(data['ModifiedDate']),
        isFeatured: data['IsFeatured'] ?? false
    );
  }*/
}

class Address {
  String street;
  String city;
  String state;
  String postalCode;
  String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['Street'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      postalCode: json['PostalCode'] ?? '',
      country: json['Country'] ?? '',
    );
  }
}
