import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/formatters/formatter.dart';

/// Model class representing user data
class UserModel{
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String role;
  String profilePicture;
  String fcmToken;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.role = 'UserType.customer',
    this.fcmToken = ''
 });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(' ');

  /// Static function to generate a username from the full name
  static String generateUsername(fullName){
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }
  /// Static function to create am empty user model
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', profilePicture: '', role: '');

  /// Convert model to Json structure for storing data
  Map<String, dynamic> toJson(){
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role':role,
      'FcmToken': fcmToken
    };
  }
  /// Factory method to create a UserModel from a firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          username: data['Username'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '',
          role: data['Role'] ?? '',
          fcmToken: data['FcmToken'] ?? ''
      );
    }else{
      return UserModel.empty();
    }
  }
}