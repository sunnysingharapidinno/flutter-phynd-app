class UserSignupPayload {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String? displayName;
  final bool isOrganization;
  final Map<String, dynamic>? companyDetails;
  final String? timezone;
  final String? timezoneLocale;
  final int? timezoneOffset;

  UserSignupPayload({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    this.displayName,
    this.isOrganization = false,
    this.companyDetails,
    this.timezone,
    this.timezoneLocale,
    this.timezoneOffset,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'isOrganization': isOrganization,
      'companyDetails': companyDetails,
      'timezone': timezone,
      'timezoneLocale': timezoneLocale,
      'timezoneOffset': timezoneOffset,
    };
  }

  factory UserSignupPayload.fromJson(Map<String, dynamic> json) {
    return UserSignupPayload(
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      displayName: json['displayName'] as String?,
      isOrganization: json['isOrganization'] as bool? ?? false,
      companyDetails: json['companyDetails'] as Map<String, dynamic>?,
      timezone: json['timezone'] as String?,
      timezoneLocale: json['timezoneLocale'] as String?,
      timezoneOffset: json['timezoneOffset'] as int?,
    );
  }
}
