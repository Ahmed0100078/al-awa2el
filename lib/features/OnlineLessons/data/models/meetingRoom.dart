class MeetingRoom {
  MeetingRoom({
    this.uuid,
    this.id,
    this.hostId,
    this.hostEmail,
    this.topic,
    this.type,
    this.status,
    this.startTime,
    this.duration,
    this.timezone,
    this.createdAt,
    this.startUrl,
    this.joinUrl,
    this.password,
    this.h323Password,
    this.pstnPassword,
    this.encryptedPassword,
    this.settings,
    this.preSchedule,
  });

  String ? uuid;
  int ? id;
  String ? hostId;
  String ? hostEmail;
  String ? topic;
  int ? type;
  String ? status;
  DateTime ?startTime;
  int ? duration;
  String ? timezone;
  DateTime ?createdAt;
  String ? startUrl;
  String ? joinUrl;
  String ? password;
  String ? h323Password;
  String ? pstnPassword;
  String ? encryptedPassword;
  Settings ?settings;
  bool ? preSchedule;

  factory MeetingRoom.fromJson(Map<String ?, dynamic> json) => MeetingRoom(
        uuid: json["uuid"] == null ? null : json["uuid"],
        id: json["id"] == null ? null : json["id"],
        hostId: json["host_id"] == null ? null : json["host_id"],
        hostEmail: json["host_email"] == null ? null : json["host_email"],
        topic: json["topic"] == null ? null : json["topic"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        duration: json["duration"] == null ? null : json["duration"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        startUrl: json["start_url"] == null ? null : json["start_url"],
        joinUrl: json["join_url"] == null ? null : json["join_url"],
        password: json["password"] == null ? null : json["password"],
        h323Password:
            json["h323_password"] == null ? null : json["h323_password"],
        pstnPassword:
            json["pstn_password"] == null ? null : json["pstn_password"],
        encryptedPassword: json["encrypted_password"] == null
            ? null
            : json["encrypted_password"],
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
        preSchedule: json["pre_schedule"] == null ? null : json["pre_schedule"],
      );

  Map<String ?, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "id": id == null ? null : id,
        "host_id": hostId == null ? null : hostId,
        "host_email": hostEmail == null ? null : hostEmail,
        "topic": topic == null ? null : topic,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "start_time": startTime == null ? null : startTime!.toIso8601String ,
        "duration": duration == null ? null : duration,
        "timezone": timezone == null ? null : timezone,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String,
        "start_url": startUrl == null ? null : startUrl,
        "join_url": joinUrl == null ? null : joinUrl,
        "password": password == null ? null : password,
        "h323_password": h323Password == null ? null : h323Password,
        "pstn_password": pstnPassword == null ? null : pstnPassword,
        "encrypted_password":
            encryptedPassword == null ? null : encryptedPassword,
        "settings": settings == null ? null : settings!.toJson(),
        "pre_schedule": preSchedule == null ? null : preSchedule,
      };
}

class Settings {
  Settings({
    this.hostVideo,
    this.participantVideo,
    this.cnMeeting,
    this.inMeeting,
    this.joinBeforeHost,
    this.jbhTime,
    this.muteUponEntry,
    this.watermark,
    this.usePmi,
    this.approvalType,
    this.audio,
    this.autoRecording,
    this.enforceLogin,
    this.enforceLoginDomains,
    this.alternativeHosts,
    this.closeRegistration,
    this.showShareButton,
    this.allowMultipleDevices,
    this.registrantsConfirmationEmail,
    this.waitingRoom,
    this.requestPermissionToUnmuteParticipants,
    this.registrantsEmailNotification,
    this.meetingAuthentication,
    this.encryptionType,
    this.approvedOrDeniedCountriesOrRegions,
    this.breakoutRoom,
    this.alternativeHostsEmailNotification,
    this.deviceTesting,
  });

  bool ? hostVideo;
  bool ? participantVideo;
  bool ? cnMeeting;
  bool ? inMeeting;
  bool ? joinBeforeHost;
  int ? jbhTime;
  bool ? muteUponEntry;
  bool ? watermark;
  bool ? usePmi;
  int ? approvalType;
  String ? audio;
  String ? autoRecording;
  bool ? enforceLogin;
  String ? enforceLoginDomains;
  String ? alternativeHosts;
  bool ? closeRegistration;
  bool ? showShareButton;
  bool ? allowMultipleDevices;
  bool ? registrantsConfirmationEmail;
  bool ? waitingRoom;
  bool ? requestPermissionToUnmuteParticipants;
  bool ? registrantsEmailNotification;
  bool ? meetingAuthentication;
  String ? encryptionType;
  ApprovedOrDeniedCountriesOrRegions ?approvedOrDeniedCountriesOrRegions;
  ApprovedOrDeniedCountriesOrRegions ?breakoutRoom;
  bool ? alternativeHostsEmailNotification;
  bool ? deviceTesting;

  factory Settings.fromJson(Map<String ?, dynamic> json) => Settings(
        hostVideo: json["host_video"] == null ? null : json["host_video"],
        participantVideo: json["participant_video"] == null
            ? null
            : json["participant_video"],
        cnMeeting: json["cn_meeting"] == null ? null : json["cn_meeting"],
        inMeeting: json["in_meeting"] == null ? null : json["in_meeting"],
        joinBeforeHost:
            json["join_before_host"] == null ? null : json["join_before_host"],
        jbhTime: json["jbh_time"] == null ? null : json["jbh_time"],
        muteUponEntry:
            json["mute_upon_entry"] == null ? null : json["mute_upon_entry"],
        watermark: json["watermark"] == null ? null : json["watermark"],
        usePmi: json["use_pmi"] == null ? null : json["use_pmi"],
        approvalType:
            json["approval_type"] == null ? null : json["approval_type"],
        audio: json["audio"] == null ? null : json["audio"],
        autoRecording:
            json["auto_recording"] == null ? null : json["auto_recording"],
        enforceLogin:
            json["enforce_login"] == null ? null : json["enforce_login"],
        enforceLoginDomains: json["enforce_login_domains"] == null
            ? null
            : json["enforce_login_domains"],
        alternativeHosts: json["alternative_hosts"] == null
            ? null
            : json["alternative_hosts"],
        closeRegistration: json["close_registration"] == null
            ? null
            : json["close_registration"],
        showShareButton: json["show_share_button"] == null
            ? null
            : json["show_share_button"],
        allowMultipleDevices: json["allow_multiple_devices"] == null
            ? null
            : json["allow_multiple_devices"],
        registrantsConfirmationEmail:
            json["registrants_confirmation_email"] == null
                ? null
                : json["registrants_confirmation_email"],
        waitingRoom: json["waiting_room"] == null ? null : json["waiting_room"],
        requestPermissionToUnmuteParticipants:
            json["request_permission_to_unmute_participants"] == null
                ? null
                : json["request_permission_to_unmute_participants"],
        registrantsEmailNotification:
            json["registrants_email_notification"] == null
                ? null
                : json["registrants_email_notification"],
        meetingAuthentication: json["meeting_authentication"] == null
            ? null
            : json["meeting_authentication"],
        encryptionType:
            json["encryption_type"] == null ? null : json["encryption_type"],
        approvedOrDeniedCountriesOrRegions:
            json["approved_or_denied_countries_or_regions"] == null
                ? null
                : ApprovedOrDeniedCountriesOrRegions.fromJson(
                    json["approved_or_denied_countries_or_regions"]),
        breakoutRoom: json["breakout_room"] == null
            ? null
            : ApprovedOrDeniedCountriesOrRegions.fromJson(
                json["breakout_room"]),
        alternativeHostsEmailNotification:
            json["alternative_hosts_email_notification"] == null
                ? null
                : json["alternative_hosts_email_notification"],
        deviceTesting:
            json["device_testing"] == null ? null : json["device_testing"],
      );

  Map<String ?, dynamic> toJson() => {
        "host_video": hostVideo == null ? null : hostVideo,
        "participant_video": participantVideo == null ? null : participantVideo,
        "cn_meeting": cnMeeting == null ? null : cnMeeting,
        "in_meeting": inMeeting == null ? null : inMeeting,
        "join_before_host": joinBeforeHost == null ? null : joinBeforeHost,
        "jbh_time": jbhTime == null ? null : jbhTime,
        "mute_upon_entry": muteUponEntry == null ? null : muteUponEntry,
        "watermark": watermark == null ? null : watermark,
        "use_pmi": usePmi == null ? null : usePmi,
        "approval_type": approvalType == null ? null : approvalType,
        "audio": audio == null ? null : audio,
        "auto_recording": autoRecording == null ? null : autoRecording,
        "enforce_login": enforceLogin == null ? null : enforceLogin,
        "enforce_login_domains":
            enforceLoginDomains == null ? null : enforceLoginDomains,
        "alternative_hosts": alternativeHosts == null ? null : alternativeHosts,
        "close_registration":
            closeRegistration == null ? null : closeRegistration,
        "show_share_button": showShareButton == null ? null : showShareButton,
        "allow_multiple_devices":
            allowMultipleDevices == null ? null : allowMultipleDevices,
        "registrants_confirmation_email": registrantsConfirmationEmail == null
            ? null
            : registrantsConfirmationEmail,
        "waiting_room": waitingRoom == null ? null : waitingRoom,
        "request_permission_to_unmute_participants":
            requestPermissionToUnmuteParticipants == null
                ? null
                : requestPermissionToUnmuteParticipants,
        "registrants_email_notification": registrantsEmailNotification == null
            ? null
            : registrantsEmailNotification,
        "meeting_authentication":
            meetingAuthentication == null ? null : meetingAuthentication,
        "encryption_type": encryptionType == null ? null : encryptionType,
        "approved_or_denied_countries_or_regions":
            approvedOrDeniedCountriesOrRegions == null
                ? null
                : approvedOrDeniedCountriesOrRegions!.toJson(),
        "breakout_room": breakoutRoom == null ? null : breakoutRoom!.toJson(),
        "alternative_hosts_email_notification":
            alternativeHostsEmailNotification == null
                ? null
                : alternativeHostsEmailNotification,
        "device_testing": deviceTesting == null ? null : deviceTesting,
      };
}

class ApprovedOrDeniedCountriesOrRegions {
  ApprovedOrDeniedCountriesOrRegions({
    this.enable,
  });

  bool ? enable;

  factory ApprovedOrDeniedCountriesOrRegions.fromJson(
          Map<String ?, dynamic> json) =>
      ApprovedOrDeniedCountriesOrRegions(
        enable: json["enable"] == null ? null : json["enable"],
      );

  Map<String ?, dynamic> toJson() => {
        "enable": enable == null ? null : enable,
      };
}
