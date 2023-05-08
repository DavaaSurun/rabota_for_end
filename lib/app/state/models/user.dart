import 'dart:convert';
import 'package:flutter/material.dart';

/// Data model for a feed MyUser's extra data.
@immutable
class MyUser {
  /// Data model for a feed MyUser's extra data.
  const MyUser({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.profilePhoto,
    required this.profilePhotoResized,
    required this.profilePhotoThumbnail,
  });

  /// Converts a Map to this.
  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      fullName: map['full_name'] as String,
      profilePhoto: map['profile_photo'] as String?,
      profilePhotoResized: map['profile_photo_resized'] as String?,
      profilePhotoThumbnail: map['profile_photo_thumbnail'] as String?,
    );
  }

  /// Converts json to this.
  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  /// MyUser's first name
  final String firstName;

  /// MyUser's last name
  final String lastName;

  /// MyUser's full name
  final String fullName;

  /// URL to MyUser's profile photo.
  final String? profilePhoto;

  /// A 500x500 version of the [profilePhoto].
  final String? profilePhotoResized;

  /// A small thumbnail version of the [profilePhoto].
  final String? profilePhotoThumbnail;

  /// Convenient method to replace certain fields.
  MyUser copyWith({
    String? firstName,
    String? lastName,
    String? fullName,
    String? profilePhoto,
    String? profilePhotoResized,
    String? profilePhotoThumbnail,
  }) {
    return MyUser(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      profilePhotoResized: profilePhotoResized ?? this.profilePhotoResized,
      profilePhotoThumbnail:
          profilePhotoThumbnail ?? this.profilePhotoThumbnail,
    );
  }

  /// Converts this model to a Map.
  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'profile_photo': profilePhoto,
      'profile_photo_resized': profilePhotoResized,
      'profile_photo_thumbnail': profilePhotoThumbnail,
    };
  }

  /// Converts this class to json.
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''MyUserData(firstName: $firstName, lastName: $lastName, fullName: $fullName, 
    profilePhoto: $profilePhoto, profilePhotoResized: $profilePhotoResized, profilePhotoThumbnail: $profilePhotoThumbnail)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.fullName == fullName &&
        other.profilePhoto == profilePhoto &&
        other.profilePhotoResized == profilePhotoResized &&
        other.profilePhotoThumbnail == profilePhotoThumbnail;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        fullName.hashCode ^
        profilePhoto.hashCode ^
        profilePhotoResized.hashCode ^
        profilePhotoThumbnail.hashCode;
  }
}
