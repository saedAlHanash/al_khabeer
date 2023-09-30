import '../../../../core/util/cheker_helper.dart';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final LoginData data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: LoginData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json["token"] ?? "",
      user: User.fromJson(json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.name1,
    required this.id,
    required this.username,
    required this.nameEn,
    required this.email,
    required this.latinName,
    required this.schoolId,
    required this.school,
    required this.stage,
    required this.stageEn,
    required this.level,
    required this.levelEn,
    required this.division,
    required this.divisionEn,
    required this.role,
    required this.children,
  });

  final int id;
  final String username;
  final String name1;
  final String nameEn;
  final dynamic email;
  final dynamic latinName;
  final String schoolId;
  final School school;
  final String stage;
  final String stageEn;
  final String level;
  final String levelEn;
  final String division;
  final String divisionEn;
  final String role;
  final List<dynamic> children;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      username: json["username"] ?? "",
      name1: json["name"] ?? "",
      nameEn: json["name_en"] ?? "",
      email: json["email"]??'',
      latinName: json["latinName"]??'',
      schoolId: json["school_id"] ?? "",
      school: School.fromJson(json["school"] ?? {}),
      stage: json["stage"] ?? "",
      stageEn: json["stage_en"] ?? "",
      level: json["level"] ?? "",
      levelEn: json["level_en"] ?? "",
      division: json["division"] ?? "",
      divisionEn: json["division_en"] ?? "",
      role: json["role"] ?? "",
      children: json["children"] == null
          ? []
          : List<dynamic>.from(json["children"]!.map((x) => x)),
    );
  }

  String get name => isAr
      ? name1
      : latinName.isEmpty
          ? name1
          : latinName;

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "name_en": nameEn,
        "email": email,
        "latinName": latinName,
        "school_id": schoolId,
        "school": school.toJson(),
        "stage": stage,
        "stage_en": stageEn,
        "level": level,
        "level_en": levelEn,
        "division": division,
        "division_en": divisionEn,
        "role": role,
        "children": children.map((x) => x).toList(),
      };
}

class School {
  School(
    this._name, {
    required this.id,
    required this.slug,
    required this.code,
    required this.slogan,
    required this.logo,
    required this.phone,
    required this.phone2,
    required this.email,
    required this.latinName,
    required this.website,
    required this.address,
    required this.welcomeMessage,
    required this.options,
    required this.socialMedia,
    required this.aboutUs,
    required this.policies,
    required this.vision,
    required this.mission,
    required this.gpsToken,
  });

  final int id;
  final String slug;
  final String _name;
  final String code;
  final dynamic slogan;
  final String logo;
  final String phone;
  final String phone2;
  final String email;
  final String latinName;
  final String website;
  final String address;
  final dynamic welcomeMessage;
  final dynamic options;
  final SocialMedia? socialMedia;
  final String aboutUs;
  final dynamic policies;
  final String vision;
  final String mission;
  final String gpsToken;

  String get name => isAr
      ? _name
      : latinName.isEmpty
          ? _name
          : latinName;

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      json["name"] ?? "",
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      code: json["code"] ?? "",
      slogan: json["slogan"],
      logo: json["logo"] ?? "",
      phone: json["phone"] ?? "",
      phone2: json["phone2"] ?? "",
      email: json["email"] ?? "",
      latinName: json["latinName"] ?? "",
      website: json["website"] ?? "",
      address: json["address"] ?? "",
      welcomeMessage: json["welcome_message"]??'',
      options: json["options"],
      socialMedia: json["social_media"] == null
          ? null
          : SocialMedia.fromJson(json["social_media"]),
      aboutUs: json["about_us"] ?? "",
      policies: json["policies"],
      vision: json["vision"] ?? "",
      mission: json["mission"] ?? "",
      gpsToken: json["gps_token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "code": code,
        "slogan": slogan,
        "logo": logo,
        "phone": phone,
        "phone2": phone2,
        "email": email,
        "latinName": latinName,
        "website": website,
        "address": address,
        "welcome_message": welcomeMessage,
        "options": options,
        "social_media": socialMedia?.toJson(),
        "about_us": aboutUs,
        "policies": policies,
        "vision": vision,
        "mission": mission,
        "gps_token": gpsToken,
      };
}

class SocialMedia {
  SocialMedia({
    required this.facebook,
    required this.instagram,
    required this.snap,
    required this.youtube,
  });

  final String facebook;
  final String instagram;
  final String snap;
  final String youtube;

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      facebook: json["facebook"] ?? "",
      instagram: json["instagram"] ?? "",
      snap: json["snap"] ?? "",
      youtube: json["youtube"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "snap": snap,
        "youtube": youtube,
      };
}
