class Member {
  final String mbrID;
  final String username;
  final String lastLoginAt;
  final String mbrFirstName;
  final String mbrFamilyName;
  final String mbrOtherNames;
  final String mbrGender;
  final String mbrPhoneNumbers;
  final String mbrEmailAddress;
  final String mbrResidentialAddress;
  final String mbrDateOfBirth;
  final String mbrOccupation;
  final String mbrRegistrationDate;
  final String mbrMembershipStatus;
  final int branchID;

  Member({
    required this.mbrID,
    required this.username,
    required this.lastLoginAt,
    required this.mbrFirstName,
    required this.mbrFamilyName,
    required this.mbrOtherNames,
    required this.mbrGender,
    required this.mbrPhoneNumbers,
    required this.mbrEmailAddress,
    required this.mbrResidentialAddress,
    required this.mbrDateOfBirth,
    required this.mbrOccupation,
    required this.mbrRegistrationDate,
    required this.mbrMembershipStatus,
    required this.branchID,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      mbrID: json['MbrID'],
      username: json['Username'],
      lastLoginAt: json['LastLoginAt'],
      mbrFirstName: json['MbrFirstName'],
      mbrFamilyName: json['MbrFamilyName'],
      mbrOtherNames: json['MbrOtherNames'],
      mbrGender: json['MbrGender'],
      mbrPhoneNumbers: json['MbrPhoneNumbers'],
      mbrEmailAddress: json['MbrEmailAddress'],
      mbrResidentialAddress: json['MbrResidentialAddress'],
      mbrDateOfBirth: json['MbrDateOfBirth'],
      mbrOccupation: json['MbrOccupation'],
      mbrRegistrationDate: json['MbrRegistrationDate'],
      mbrMembershipStatus: json['MbrMembershipStatus'],
      branchID: json['BranchID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "MbrID": mbrID,
      "Username": username,
      "LastLoginAt": lastLoginAt,
      "MbrFirstName": mbrFirstName,
      "MbrFamilyName": mbrFamilyName,
      "MbrOtherNames": mbrOtherNames,
      "MbrGender": mbrGender,
      "MbrPhoneNumbers": mbrPhoneNumbers,
      "MbrEmailAddress": mbrEmailAddress,
      "MbrResidentialAddress": mbrResidentialAddress,
      "MbrDateOfBirth": mbrDateOfBirth,
      "MbrOccupation": mbrOccupation,
      "MbrRegistrationDate": mbrRegistrationDate,
      "MbrMembershipStatus": mbrMembershipStatus,
      "BranchID": branchID,
    };
  }
}
