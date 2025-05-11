
class OverviewModel {
  final Bio bio;
  final DashboardOverview dashboardOverview;
  final List<RecentRegistration> recentRegistrations;

  OverviewModel({
    required this.bio,
    required this.dashboardOverview,
    required this.recentRegistrations,
  });

  factory OverviewModel.fromJson(Map<dynamic, dynamic> json) {
    return OverviewModel(
      bio: Bio.fromJson(json['bio']),
      dashboardOverview: DashboardOverview.fromJson(json['dashboard_overview']),
      recentRegistrations: (json['recent_registrations'] as List)
          .map((e) => RecentRegistration.fromJson(e))
          .toList(),
    );
  }
}

class Bio {
  final String mbrCustomID;
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
  final int authUserID;
  final String mbrID;
  final String username;
  final String passwordText;
  final String passwordHash;
  final String createdAt;
  final String lastLoginAt;

  Bio({
    required this.mbrCustomID,
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
    required this.authUserID,
    required this.mbrID,
    required this.username,
    required this.passwordText,
    required this.passwordHash,
    required this.createdAt,
    required this.lastLoginAt,
  });

  factory Bio.fromJson(Map<dynamic, dynamic> json) {
    return Bio(
      mbrCustomID: json['MbrCustomID'],
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
      authUserID: json['AuthUserID'],
      mbrID: json['MbrID'],
      username: json['Username'],
      passwordText: json['passwordText'],
      passwordHash: json['PasswordHash'],
      createdAt: json['CreatedAt'],
      lastLoginAt: json['LastLoginAt'],
    );
  }
}

class DashboardOverview {
  final int activeUsers;
  final int monthlyRevenue;
  final double averageMidweekServiceAttendance;
  final double averageSundayServiceAttendance;

  DashboardOverview({
    required this.activeUsers,
    required this.monthlyRevenue,
    required this.averageMidweekServiceAttendance,
    required this.averageSundayServiceAttendance,
  });

  factory DashboardOverview.fromJson(Map<dynamic, dynamic> json) {
    return DashboardOverview(
      activeUsers: json['active_users'] ?? 0.0,
      monthlyRevenue: json['monthly_revenue'] ?? 0.0,
      averageMidweekServiceAttendance:
          json['average_midweek_service_attendance'],
      averageSundayServiceAttendance:
          double.parse(json['average_sunday_service_attendance']),
    );
  }
}

class RecentRegistration {
  final String mbrCustomID;
  final String mbrFirstName;
  final String mbrFamilyName;
  final String mbrRegistrationDate;

  RecentRegistration({
    required this.mbrCustomID,
    required this.mbrFirstName,
    required this.mbrFamilyName,
    required this.mbrRegistrationDate,
  });

  factory RecentRegistration.fromJson(Map<dynamic, dynamic> json) {
    return RecentRegistration(
      mbrCustomID: json['MbrCustomID'],
      mbrFirstName: json['MbrFirstName'],
      mbrFamilyName: json['MbrFamilyName'],
      mbrRegistrationDate: json['MbrRegistrationDate'],
    );
  }
}
