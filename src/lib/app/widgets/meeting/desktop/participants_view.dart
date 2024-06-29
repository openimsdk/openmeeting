import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/app/widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'package:sprintf/sprintf.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/define.dart';
import '../../../data/models/meeting.pb.dart';
import '../participant_info.dart';
import 'meeting_pop_menu.dart';

abstract class ParticipantsView extends StatefulWidget {
  const ParticipantsView(
      {super.key,
      required this.participantsSubject,
      required this.meetingInfoChangedSubject,
      required this.loginUserID,
      this.onOperation,
      this.onRoomOperation});

  final BehaviorSubject<List<ParticipantTrack>> participantsSubject;
  final BehaviorSubject<MeetingInfoSetting> meetingInfoChangedSubject;
  final String loginUserID;
  final void Function<T>(BuildContext? context, OperationType type, {T? value})? onRoomOperation;
  final Future<bool> Function<T>({OperationParticipantType type, String userID, T to})?
      onOperation; // {OptionType.invite, OptionType.participants>
}

abstract class ParticipantsViewState<T extends ParticipantsView> extends State<T> {
  late StreamSubscription _participantsSub;
  late StreamSubscription _meetingInfSub;
  List<ParticipantTrack> _participantTracks = [];
  MeetingInfoSetting? _meetingInfo;

  bool muteAll = false;
  MeetingSetting? get setting => _meetingInfo?.setting;
  bool get isHost => _meetingInfo?.hostUserID == widget.loginUserID;

  @override
  void initState() {
    super.initState();

    _participantsSub = widget.participantsSubject.listen(_onChangedParticipants);
    _meetingInfSub = widget.meetingInfoChangedSubject.listen(_onChangedMeetingInfo);
  }

  @override
  void dispose() {
    _participantsSub.cancel();
    _meetingInfSub.cancel();
    super.dispose();
  }

  void _onChangedParticipants(List<ParticipantTrack> tracks) {
    setState(() {
      _participantTracks = tracks;
    });
  }

  void _onChangedMeetingInfo(MeetingInfoSetting info) {
    setState(() {
      _meetingInfo = info;
    });
  }
}

class ParticipantsDesktopView extends ParticipantsView {
  const ParticipantsDesktopView(
      {super.key,
      required super.participantsSubject,
      required super.meetingInfoChangedSubject,
      required super.loginUserID,
      super.onOperation,
      super.onRoomOperation,
      this.onRollup});

  final VoidCallback? onRollup;

  @override
  ParticipantsViewState<ParticipantsDesktopView> createState() => _ParticipantsDesktopViewState();
}

class _ParticipantsDesktopViewState extends ParticipantsViewState<ParticipantsDesktopView> {
  List<ParticipantTrack> _searchResult = [];
  final TextEditingController _searchController = TextEditingController();
  ValueNotifier<({bool cameraIsEnable, bool micIsEnable, String nickname, String userID})> valueNotifier =
      ValueNotifier((cameraIsEnable: false, micIsEnable: false, nickname: '', userID: ''));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buildTitle(),
          const SizedBox(
            height: 16,
          ),
          _buildSearchBar(),
          Flexible(
            child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) => _searchController.text.isNotEmpty
                    ? _buildItem(_searchResult[index])
                    : _buildItem(_participantTracks[index]),
                separatorBuilder: (context, index) => SizedBox(
                      height: 12.h,
                    ),
                itemCount: _searchController.text.isNotEmpty ? _searchResult.length : _participantTracks.length),
          ),
          if (isHost) _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      height: 32.h,
      color: ColorsExt.c_1890FF.withOpacity(0.05),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(
            Icons.people_rounded,
            color: Styles.c_8E9AB0,
            size: 16,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            sprintf(StrRes.meetingMembers, [_participantTracks.length]),
            style: TextStyle(color: Styles.c_8E9AB0, fontSize: 14),
          ),
          const Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              StrRes.rollUp,
              style: Styles.ts_0089FF_14sp,
            ),
            onPressed: () {
              widget.onRollup?.call();
            },
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoSearchTextField(
        controller: _searchController,
        decoration: BoxDecoration(
          border: Border.all(color: Styles.c_E8EAEF),
          borderRadius: BorderRadius.circular(6),
        ),
        onChanged: (value) {
          final result = _participantTracks.where((element) {
            final contains = element.nickname.contains(value);
            Logger.print('contains: $contains - nickname: ${element.nickname}');
            return contains;
          }).toList();
          Logger.print('search count: ${result.length}');
          setState(() {
            _searchResult = result;
          });
        },
      ),
    );
  }

  Widget _buildBottomButtons() {
    Widget buildButton(String title, VoidCallback onPressed) {
      return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              color: Styles.c_E8EAEF,
              width: 1,
            ),
          ),
        ),
        child: Text(
          title,
          style: Styles.ts_0C1C33_14sp,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Builder(
          builder: (ctx) => buildButton(StrRes.meetingRoomSetting, () {
            _meetingRoomSetting(ctx);
          }),
        ),
        buildButton(StrRes.muteAll, () {
          _muteAll(true);
        }),
        buildButton(StrRes.unmuteAll, () {
          _muteAll(false);
        }),
      ],
    );
  }

  Widget _buildItem(ParticipantTrack track) {
    final userID = track.participant.identity;

    var data = jsonDecode(track.participant.metadata!);
    final userInfo = data['userInfo'];
    String nickname = userInfo['nickname'] ?? userID;
    final faceURL = userInfo?['faceURL'];

    final isMicrophoneEnabled = track.participant.isMicrophoneEnabled();
    final isCameraEnabled = track.participant.isCameraEnabled();

    return Row(
      children: [
        AvatarView(
          url: faceURL,
          text: nickname,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nickname.toText
              ..style = Styles.ts_0C1C33_17sp
              ..maxLines = 1
              ..overflow = TextOverflow.ellipsis,
            if (userID == _meetingInfo?.hostUserID)
              Text(
                '(${StrRes.meetingHost}, ${StrRes.me})',
                style: Styles.ts_8E9AB0_12sp,
              )
          ],
        ),
        const Spacer(),
        if (isHost) // only login user is host
          Row(
            children: [
              _buildButtonInItem(isMicrophoneEnabled ? ImageRes.meetingMicOnGray : ImageRes.meetingMicOffGray, () {
                _disableParticipantMicrophone(userID, !isMicrophoneEnabled);
              }),
              _buildButtonInItem(isCameraEnabled ? ImageRes.meetingCameraOnGray : ImageRes.meetingCameraOffGray, () {
                _disableParticipantCamera(userID, !isCameraEnabled);
              }),
              Builder(
                builder: (ctx) => _buildButtonInItem(
                  ImageRes.meetingMore,
                  () {
                    _onTapMore(ctx, userID, nickname);
                  },
                ),
              ),
            ],
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildButtonInItem(String image, VoidCallback onTap) {
    return IconButton(
        onPressed: onTap,
        icon: image.toImage
          ..width = 24
          ..height = 24);
  }

/*
  void _pineParticipant(String userID, bool pined) async {
    final result = await widget.onOperation?.call(OperationParticipantType.pined, userID, pined);

    if (result == true) {
      if (pined) {
        setting.pinedUserIDList?.add(userID);
      } else {
        setting.pinedUserIDList?.remove(userID);
      }
      setState(() {
        _meetingInfo;
      });
    }
  }

  void _allSeeHim(String userID, bool focus) async {
    final result = await widget.onOperation?.call(OperationParticipantType.focus, userID, focus);

    if (result == true) {
      if (focus) {
        setting.beWatchedUserIDList?.clear();
        setting.beWatchedUserIDList?.add(userID);
      } else {
        setting.beWatchedUserIDList?.remove(userID);
      }
      setState(() {
        _meetingInfo;
      });
    }
  }
*/
  void _disableParticipantCamera(String userID, bool disable) {
    widget.onOperation?.call(type: OperationParticipantType.camera, userID: userID, to: disable);
  }

  void _disableParticipantMicrophone(String userID, bool disable) {
    widget.onOperation?.call(type: OperationParticipantType.microphone, userID: userID, to: disable);
  }

  void _muteAll(bool muteAll) async {
    if (muteAll) {
      MeetingAlertDialog.showMuteAll(context, onConfirm: (canEnableMicphone) async {
        await widget.onOperation?.call(type: OperationParticipantType.muteAll, userID: '', to: muteAll);
        if (mounted) {
          setting?.canParticipantsUnmuteMicrophone = canEnableMicphone;
          widget.onRoomOperation?.call(context, OperationType.roomSettings, value: setting);
        }
      });
    } else {
      await widget.onOperation?.call(type: OperationParticipantType.muteAll, userID: '', to: muteAll);
    }
  }

  void _meetingRoomSetting(BuildContext ctx) {
    MeetingPopMenu.showRoomSetting(ctx,
        allowParticipantUnMute: setting?.canParticipantsUnmuteMicrophone == true,
        allowParticipantVideo: setting?.canParticipantsEnableCamera == true,
        onlyHostCanShareScreen: setting?.canParticipantsShareScreen == false,
        defaultMuted: setting?.disableMicrophoneOnJoin == true, onOperation: (type, to) {
      switch (type) {
        case RoomSetting.allowParticipantUnMute:
          setting?.canParticipantsUnmuteMicrophone = to;
          break;
        case RoomSetting.allowParticipantVideo:
          setting?.canParticipantsEnableCamera = to;
          break;
        case RoomSetting.onlyHostCanShareScreen:
          setting?.canParticipantsShareScreen = to;
          break;
        case RoomSetting.defaultMuted:
          setting?.disableMicrophoneOnJoin = to;
          break;
      }

      return Future(() => true);
    }, onPop: () {
      widget.onRoomOperation?.call(context, OperationType.roomSettings, value: setting);
    });
  }

  void _onTapMore(BuildContext ctx, String userID, String nickname) {
    final itemIsHost = userID == _meetingInfo?.creatorUserID;

    MeetingAlertDialog.showMemberSetting(ctx, forMobile: false, valueNotifier: valueNotifier, onEnableCamera: () {
      _disableParticipantCamera(userID, !valueNotifier.value.cameraIsEnable);
    }, onEnableMic: () {
      _disableParticipantMicrophone(userID, !valueNotifier.value.micIsEnable);
    }, onChangeNickname: () {
      MeetingAlertDialog.showInputText(context, title: StrRes.changeNickname, nickname: nickname, onConfirm: (value) {
        widget.onOperation?.call(type: OperationParticipantType.nickname, userID: userID, to: value);
      });
    },
        onSetHost: itemIsHost
            ? null
            : () {
                widget.onOperation?.call(type: OperationParticipantType.setHost, userID: userID);
              },
        onKickoff: itemIsHost
            ? null
            : () {
                widget.onOperation?.call(type: OperationParticipantType.kickoff, userID: userID);
              });
  }
}
