
class MeetingOptions {
  final bool enableMicrophone;
  final bool enableSpeaker;
  final bool enableVideo;
  final bool videoIsMirroring;

  const MeetingOptions({
    this.enableMicrophone = true,
    this.enableSpeaker = true,
    this.enableVideo = true,
    this.videoIsMirroring = false,
  });

  factory MeetingOptions.fromMap(Map<String, dynamic> json) => MeetingOptions(
        enableMicrophone: json['enableMicrophone'],
        enableSpeaker: json['enableSpeaker'],
        enableVideo: json['enableVideo'],
        videoIsMirroring: json['videoIsMirroring'],
      );

  Map<String, dynamic> toMap() => {
        'enableMicrophone': enableMicrophone,
        'enableSpeaker': enableSpeaker,
        'enableVideo': enableVideo,
        'videoIsMirroring': videoIsMirroring,
      };
}
