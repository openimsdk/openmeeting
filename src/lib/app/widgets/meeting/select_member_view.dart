import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/widgets/meeting/participant_info.dart';

import '../../data/models/meeting.pb.dart';

abstract class SelectMemberView extends StatefulWidget {
  const SelectMemberView({super.key, required this.participants, required this.onSelected});

  final List<ParticipantTrack> participants;
  final ValueChanged<String> onSelected;
}

abstract class SelectMemberViewState<T extends SelectMemberView> extends State<T> {
  String? _selectedUserID;

  set selectedUserID(String? value) {
    setState(() {
      _selectedUserID = value;
    });
  }

  String? get selectedUserID => _selectedUserID;

  @override
  void initState() {
    _selectedUserID = widget.participants.firstOrNull?.participant.identity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context);

  Widget buildList(BuildContext context, {double height = 30}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.participants.length,
      itemBuilder: (context, index) {
        final participant = widget.participants[index];
        var data = jsonDecode(participant.participant.metadata!);
        final userInfo = UserInfo()..mergeFromProto3Json(data['userInfo']);
        final userID = userInfo.userID;
        final nickname = userInfo.nickname;

        return ListTile(
          dense: true,
          leading: AvatarView(
            text: nickname,
            height: height,
          ),
          title: nickname.toText..style = Styles.ts_0C1C33_12sp,
          trailing: selectedUserID == userID ? Icon(Icons.check, color: Styles.c_0089FF) : null,
          onTap: () {
            selectedUserID = userID;
          },
        );
      },
    );
  }
}

class SelectMemberViewForMobile extends SelectMemberView {
  const SelectMemberViewForMobile({super.key, required super.participants, required super.onSelected});

  @override
  SelectMemberViewForMobileState createState() => SelectMemberViewForMobileState();
}

class SelectMemberViewForMobileState extends SelectMemberViewState<SelectMemberViewForMobile> {
  @override
  Widget buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.zero,
            topRight: Radius.circular(8.0),
            bottomRight: Radius.zero),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _selectedUserID == null
                ? null
                : () {
                    widget.onSelected(selectedUserID!);
                  },
            child: Text(
              StrRes.determine,
              style: Styles.ts_0C1C33_14sp,
            ),
          ),
          const Divider(
            height: 1,
          ),
          buildList(context, height: 42),
        ],
      ),
    );
  }
}

class SelectMemberViewForDesktop extends SelectMemberView {
  const SelectMemberViewForDesktop({super.key, required super.participants, required super.onSelected});

  @override
  SelectMemberViewForDesktopState createState() => SelectMemberViewForDesktopState();
}

class SelectMemberViewForDesktopState extends SelectMemberViewState<SelectMemberViewForDesktop> {
  @override
  Widget buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StrRes.setHost,
            style: Styles.ts_0C1C33_17sp,
          ),
          buildList(context),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 30,
            child: CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  StrRes.assignAndLeave,
                ),
                onPressed: () {
                  widget.onSelected(selectedUserID!);
                }),
          ),
        ],
      ),
    );
  }
}
