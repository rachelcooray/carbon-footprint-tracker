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
import 'dart:async' as _i2;
import 'package:carbon_footprint_client/src/protocol/action_log.dart' as _i3;
import 'package:carbon_footprint_client/src/protocol/butler_message.dart'
    as _i4;
import 'package:carbon_footprint_client/src/protocol/butler_event.dart' as _i5;
import 'package:carbon_footprint_client/src/protocol/challenge_progress.dart'
    as _i6;
import 'package:carbon_footprint_client/src/protocol/community_group.dart'
    as _i7;
import 'package:carbon_footprint_client/src/protocol/eco_action.dart' as _i8;
import 'package:carbon_footprint_client/src/protocol/social_post.dart' as _i9;
import 'package:carbon_footprint_client/src/protocol/user_stats.dart' as _i10;
import 'package:carbon_footprint_client/src/protocol/user_profile.dart' as _i11;
import 'package:carbon_footprint_client/src/protocol/badge.dart' as _i12;
import 'package:carbon_footprint_client/src/protocol/greeting.dart' as _i13;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i14;
import 'protocol.dart' as _i15;

/// {@category Endpoint}
class EndpointAction extends _i1.EndpointRef {
  EndpointAction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'action';

  _i2.Future<void> logAction(_i3.ActionLog log) =>
      caller.callServerEndpoint<void>(
        'action',
        'logAction',
        {'log': log},
      );

  _i2.Future<List<_i3.ActionLog>> getActions(int dummyId) =>
      caller.callServerEndpoint<List<_i3.ActionLog>>(
        'action',
        'getActions',
        {'dummyId': dummyId},
      );
}

/// {@category Endpoint}
class EndpointButler extends _i1.EndpointRef {
  EndpointButler(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'butler';

  _i2.Future<List<_i4.ButlerMessage>> getChatHistory() =>
      caller.callServerEndpoint<List<_i4.ButlerMessage>>(
        'butler',
        'getChatHistory',
        {},
      );

  _i2.Future<void> sendMessage(String text) => caller.callServerEndpoint<void>(
        'butler',
        'sendMessage',
        {'text': text},
      );

  _i2.Future<List<_i5.ButlerEvent>> getActiveSuggestions() =>
      caller.callServerEndpoint<List<_i5.ButlerEvent>>(
        'butler',
        'getActiveSuggestions',
        {},
      );

  _i2.Future<String> generateDailyBriefing() =>
      caller.callServerEndpoint<String>(
        'butler',
        'generateDailyBriefing',
        {},
      );
}

/// {@category Endpoint}
class EndpointChallenge extends _i1.EndpointRef {
  EndpointChallenge(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'challenge';

  _i2.Future<List<_i6.ChallengeProgress>> getUserChallenges(int dummyId) =>
      caller.callServerEndpoint<List<_i6.ChallengeProgress>>(
        'challenge',
        'getUserChallenges',
        {'dummyId': dummyId},
      );
}

/// {@category Endpoint}
class EndpointCommunity extends _i1.EndpointRef {
  EndpointCommunity(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'community';

  _i2.Future<List<_i7.CommunityGroup>> getGroups() =>
      caller.callServerEndpoint<List<_i7.CommunityGroup>>(
        'community',
        'getGroups',
        {},
      );

  _i2.Future<void> createGroup(
    String name,
    String description,
  ) =>
      caller.callServerEndpoint<void>(
        'community',
        'createGroup',
        {
          'name': name,
          'description': description,
        },
      );

  _i2.Future<void> joinGroup(int groupId) => caller.callServerEndpoint<void>(
        'community',
        'joinGroup',
        {'groupId': groupId},
      );

  _i2.Future<List<_i7.CommunityGroup>> getMyGroups() =>
      caller.callServerEndpoint<List<_i7.CommunityGroup>>(
        'community',
        'getMyGroups',
        {},
      );
}

/// {@category Endpoint}
class EndpointEcoAction extends _i1.EndpointRef {
  EndpointEcoAction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ecoAction';

  _i2.Future<List<_i8.EcoAction>> getAllActions() =>
      caller.callServerEndpoint<List<_i8.EcoAction>>(
        'ecoAction',
        'getAllActions',
        {},
      );
}

/// {@category Endpoint}
class EndpointSeed extends _i1.EndpointRef {
  EndpointSeed(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  _i2.Future<String> seedData() => caller.callServerEndpoint<String>(
        'seed',
        'seedData',
        {},
      );
}

/// {@category Endpoint}
class EndpointSocial extends _i1.EndpointRef {
  EndpointSocial(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'social';

  _i2.Future<List<_i9.SocialPost>> getFeed() =>
      caller.callServerEndpoint<List<_i9.SocialPost>>(
        'social',
        'getFeed',
        {},
      );

  _i2.Future<double> getGlobalImpact() => caller.callServerEndpoint<double>(
        'social',
        'getGlobalImpact',
        {},
      );

  _i2.Future<void> cheerUser(int targetUserId) =>
      caller.callServerEndpoint<void>(
        'social',
        'cheerUser',
        {'targetUserId': targetUserId},
      );

  _i2.Future<void> nudgeUser(int targetUserId) =>
      caller.callServerEndpoint<void>(
        'social',
        'nudgeUser',
        {'targetUserId': targetUserId},
      );
}

/// {@category Endpoint}
class EndpointStats extends _i1.EndpointRef {
  EndpointStats(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'stats';

  _i2.Future<_i10.UserStats> getUserStats(int dummyId) =>
      caller.callServerEndpoint<_i10.UserStats>(
        'stats',
        'getUserStats',
        {'dummyId': dummyId},
      );

  _i2.Future<List<_i11.UserProfile>> getLeaderboard() =>
      caller.callServerEndpoint<List<_i11.UserProfile>>(
        'stats',
        'getLeaderboard',
        {},
      );

  _i2.Future<List<_i12.Badge>> getBadges() =>
      caller.callServerEndpoint<List<_i12.Badge>>(
        'stats',
        'getBadges',
        {},
      );

  _i2.Future<void> updateMonthlyBudget(double budget) =>
      caller.callServerEndpoint<void>(
        'stats',
        'updateMonthlyBudget',
        {'budget': budget},
      );
}

/// This is an example endpoint that returns a greeting message through its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i13.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i13.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i14.Caller(client);
  }

  late final _i14.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i15.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    action = EndpointAction(this);
    butler = EndpointButler(this);
    challenge = EndpointChallenge(this);
    community = EndpointCommunity(this);
    ecoAction = EndpointEcoAction(this);
    seed = EndpointSeed(this);
    social = EndpointSocial(this);
    stats = EndpointStats(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointAction action;

  late final EndpointButler butler;

  late final EndpointChallenge challenge;

  late final EndpointCommunity community;

  late final EndpointEcoAction ecoAction;

  late final EndpointSeed seed;

  late final EndpointSocial social;

  late final EndpointStats stats;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'action': action,
        'butler': butler,
        'challenge': challenge,
        'community': community,
        'ecoAction': ecoAction,
        'seed': seed,
        'social': social,
        'stats': stats,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
