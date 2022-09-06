/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/6/22, 5:27 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */



class ProfilesDataStructure {

  static const String profileUidName = "profileUid";

  static const String profileUsernameName = "profileUsername";
  static const String profileImageName = "profileImage";

  static const String profileEmailName = "profileEmail";
  static const String profilePhoneNumberName = "profilePhoneNumber";

  static const String profileTwitterName = "profileTwitter";
  static const String profileFacebookName = "profileFacebook";
  static const String profileInstagramName = "profileInstagram";

  Map<String, dynamic> profilesDocumentData = <String, dynamic>{};

  ProfilesDataStructure(String profileUidName,
    String profileUsernameName, String profileImageName,
    String profileEmailName, String profilePhoneNumberName,
    String profileTwitterName, String profileFacebookName, String profileInstagramName) {

    profilesDocumentData[ProfilesDataStructure.profileUidName] = profileUidName;

    profilesDocumentData[ProfilesDataStructure.profileUsernameName] = profileUsernameName;
    profilesDocumentData[ProfilesDataStructure.profileImageName] = profileImageName;

    profilesDocumentData[ProfilesDataStructure.profileEmailName] = profileEmailName;
    profilesDocumentData[ProfilesDataStructure.profilePhoneNumberName] = profilePhoneNumberName;

    profilesDocumentData[ProfilesDataStructure.profileTwitterName] = profileTwitterName;
    profilesDocumentData[ProfilesDataStructure.profileFacebookName] = profileFacebookName;
    profilesDocumentData[ProfilesDataStructure.profileInstagramName] = profileInstagramName;

  }

  Map<String, dynamic> profileInformation() {

    return profilesDocumentData;
  }

}