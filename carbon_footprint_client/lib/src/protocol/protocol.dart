/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'greeting.dart' as _i2;
import 'action_log.dart' as _i3;
import 'badge.dart' as _i4;
import 'butler_event.dart' as _i5;
import 'butler_message.dart' as _i6;
import 'challenge.dart' as _i7;
import 'challenge_progress.dart' as _i8;
import 'community_group.dart' as _i9;
import 'eco_action.dart' as _i10;
import 'ecotrajectory.dart' as _i11;
import 'group_member.dart' as _i12;
import 'social_post.dart' as _i13;
import 'user_profile.dart' as _i14;
import 'user_stats.dart' as _i15;
import 'package:carbon_footprint_client/src/protocol/action_log.dart' as _i16;
import 'package:carbon_footprint_client/src/protocol/butler_message.dart'
    as _i17;
import 'package:carbon_footprint_client/src/protocol/butler_event.dart' as _i18;
import 'package:carbon_footprint_client/src/protocol/challenge_progress.dart'
    as _i19;
import 'package:carbon_footprint_client/src/protocol/community_group.dart'
    as _i20;
import 'package:carbon_footprint_client/src/protocol/eco_action.dart' as _i21;
import 'package:carbon_footprint_client/src/protocol/social_post.dart' as _i22;
import 'package:carbon_footprint_client/src/protocol/user_profile.dart' as _i23;
import 'package:carbon_footprint_client/src/protocol/badge.dart' as _i24;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i25;
export 'greeting.dart';
export 'action_log.dart';
export 'badge.dart';
export 'butler_event.dart';
export 'butler_message.dart';
export 'challenge.dart';
export 'challenge_progress.dart';
export 'community_group.dart';
export 'eco_action.dart';
export 'ecotrajectory.dart';
export 'group_member.dart';
export 'social_post.dart';
export 'user_profile.dart';
export 'user_stats.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.ActionLog) {
      return _i3.ActionLog.fromJson(data) as T;
    }
    if (t == _i4.Badge) {
      return _i4.Badge.fromJson(data) as T;
    }
    if (t == _i5.ButlerEvent) {
      return _i5.ButlerEvent.fromJson(data) as T;
    }
    if (t == _i6.ButlerMessage) {
      return _i6.ButlerMessage.fromJson(data) as T;
    }
    if (t == _i7.Challenge) {
      return _i7.Challenge.fromJson(data) as T;
    }
    if (t == _i8.ChallengeProgress) {
      return _i8.ChallengeProgress.fromJson(data) as T;
    }
    if (t == _i9.CommunityGroup) {
      return _i9.CommunityGroup.fromJson(data) as T;
    }
    if (t == _i10.EcoAction) {
      return _i10.EcoAction.fromJson(data) as T;
    }
    if (t == _i11.Ecotrajectory) {
      return _i11.Ecotrajectory.fromJson(data) as T;
    }
    if (t == _i12.GroupMember) {
      return _i12.GroupMember.fromJson(data) as T;
    }
    if (t == _i13.SocialPost) {
      return _i13.SocialPost.fromJson(data) as T;
    }
    if (t == _i14.UserProfile) {
      return _i14.UserProfile.fromJson(data) as T;
    }
    if (t == _i15.UserStats) {
      return _i15.UserStats.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ActionLog?>()) {
      return (data != null ? _i3.ActionLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Badge?>()) {
      return (data != null ? _i4.Badge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ButlerEvent?>()) {
      return (data != null ? _i5.ButlerEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ButlerMessage?>()) {
      return (data != null ? _i6.ButlerMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Challenge?>()) {
      return (data != null ? _i7.Challenge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ChallengeProgress?>()) {
      return (data != null ? _i8.ChallengeProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CommunityGroup?>()) {
      return (data != null ? _i9.CommunityGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.EcoAction?>()) {
      return (data != null ? _i10.EcoAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Ecotrajectory?>()) {
      return (data != null ? _i11.Ecotrajectory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.GroupMember?>()) {
      return (data != null ? _i12.GroupMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.SocialPost?>()) {
      return (data != null ? _i13.SocialPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.UserProfile?>()) {
      return (data != null ? _i14.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UserStats?>()) {
      return (data != null ? _i15.UserStats.fromJson(data) : null) as T;
    }
    if (t == List<_i16.ActionLog>) {
      return (data as List).map((e) => deserialize<_i16.ActionLog>(e)).toList()
          as T;
    }
    if (t == List<_i17.ButlerMessage>) {
      return (data as List)
          .map((e) => deserialize<_i17.ButlerMessage>(e))
          .toList() as T;
    }
    if (t == List<_i18.ButlerEvent>) {
      return (data as List)
          .map((e) => deserialize<_i18.ButlerEvent>(e))
          .toList() as T;
    }
    if (t == List<_i19.ChallengeProgress>) {
      return (data as List)
          .map((e) => deserialize<_i19.ChallengeProgress>(e))
          .toList() as T;
    }
    if (t == List<_i20.CommunityGroup>) {
      return (data as List)
          .map((e) => deserialize<_i20.CommunityGroup>(e))
          .toList() as T;
    }
    if (t == List<_i21.EcoAction>) {
      return (data as List).map((e) => deserialize<_i21.EcoAction>(e)).toList()
          as T;
    }
    if (t == List<_i22.SocialPost>) {
      return (data as List).map((e) => deserialize<_i22.SocialPost>(e)).toList()
          as T;
    }
    if (t == List<_i23.UserProfile>) {
      return (data as List)
          .map((e) => deserialize<_i23.UserProfile>(e))
          .toList() as T;
    }
    if (t == List<_i24.Badge>) {
      return (data as List).map((e) => deserialize<_i24.Badge>(e)).toList()
          as T;
    }
    try {
      return _i25.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Greeting) {
      return 'Greeting';
    }
    if (data is _i3.ActionLog) {
      return 'ActionLog';
    }
    if (data is _i4.Badge) {
      return 'Badge';
    }
    if (data is _i5.ButlerEvent) {
      return 'ButlerEvent';
    }
    if (data is _i6.ButlerMessage) {
      return 'ButlerMessage';
    }
    if (data is _i7.Challenge) {
      return 'Challenge';
    }
    if (data is _i8.ChallengeProgress) {
      return 'ChallengeProgress';
    }
    if (data is _i9.CommunityGroup) {
      return 'CommunityGroup';
    }
    if (data is _i10.EcoAction) {
      return 'EcoAction';
    }
    if (data is _i11.Ecotrajectory) {
      return 'Ecotrajectory';
    }
    if (data is _i12.GroupMember) {
      return 'GroupMember';
    }
    if (data is _i13.SocialPost) {
      return 'SocialPost';
    }
    if (data is _i14.UserProfile) {
      return 'UserProfile';
    }
    if (data is _i15.UserStats) {
      return 'UserStats';
    }
    className = _i25.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'ActionLog') {
      return deserialize<_i3.ActionLog>(data['data']);
    }
    if (dataClassName == 'Badge') {
      return deserialize<_i4.Badge>(data['data']);
    }
    if (dataClassName == 'ButlerEvent') {
      return deserialize<_i5.ButlerEvent>(data['data']);
    }
    if (dataClassName == 'ButlerMessage') {
      return deserialize<_i6.ButlerMessage>(data['data']);
    }
    if (dataClassName == 'Challenge') {
      return deserialize<_i7.Challenge>(data['data']);
    }
    if (dataClassName == 'ChallengeProgress') {
      return deserialize<_i8.ChallengeProgress>(data['data']);
    }
    if (dataClassName == 'CommunityGroup') {
      return deserialize<_i9.CommunityGroup>(data['data']);
    }
    if (dataClassName == 'EcoAction') {
      return deserialize<_i10.EcoAction>(data['data']);
    }
    if (dataClassName == 'Ecotrajectory') {
      return deserialize<_i11.Ecotrajectory>(data['data']);
    }
    if (dataClassName == 'GroupMember') {
      return deserialize<_i12.GroupMember>(data['data']);
    }
    if (dataClassName == 'SocialPost') {
      return deserialize<_i13.SocialPost>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i14.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserStats') {
      return deserialize<_i15.UserStats>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i25.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
