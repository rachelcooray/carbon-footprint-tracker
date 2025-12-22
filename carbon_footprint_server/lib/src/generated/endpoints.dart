/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/action_endpoint.dart' as _i2;
import '../endpoints/butler_endpoint.dart' as _i3;
import '../endpoints/challenge_endpoint.dart' as _i4;
import '../endpoints/community_endpoint.dart' as _i5;
import '../endpoints/eco_action_endpoint.dart' as _i6;
import '../endpoints/seed_endpoint.dart' as _i7;
import '../endpoints/social_endpoint.dart' as _i8;
import '../endpoints/stats_endpoint.dart' as _i9;
import '../greeting_endpoint.dart' as _i10;
import 'package:carbon_footprint_server/src/generated/action_log.dart' as _i11;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'action': _i2.ActionEndpoint()
        ..initialize(
          server,
          'action',
          null,
        ),
      'butler': _i3.ButlerEndpoint()
        ..initialize(
          server,
          'butler',
          null,
        ),
      'challenge': _i4.ChallengeEndpoint()
        ..initialize(
          server,
          'challenge',
          null,
        ),
      'community': _i5.CommunityEndpoint()
        ..initialize(
          server,
          'community',
          null,
        ),
      'ecoAction': _i6.EcoActionEndpoint()
        ..initialize(
          server,
          'ecoAction',
          null,
        ),
      'seed': _i7.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'social': _i8.SocialEndpoint()
        ..initialize(
          server,
          'social',
          null,
        ),
      'stats': _i9.StatsEndpoint()
        ..initialize(
          server,
          'stats',
          null,
        ),
      'greeting': _i10.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['action'] = _i1.EndpointConnector(
      name: 'action',
      endpoint: endpoints['action']!,
      methodConnectors: {
        'logAction': _i1.MethodConnector(
          name: 'logAction',
          params: {
            'log': _i1.ParameterDescription(
              name: 'log',
              type: _i1.getType<_i11.ActionLog>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['action'] as _i2.ActionEndpoint).logAction(
            session,
            params['log'],
          ),
        ),
        'getActions': _i1.MethodConnector(
          name: 'getActions',
          params: {
            'dummyId': _i1.ParameterDescription(
              name: 'dummyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['action'] as _i2.ActionEndpoint).getActions(
            session,
            params['dummyId'],
          ),
        ),
      },
    );
    connectors['butler'] = _i1.EndpointConnector(
      name: 'butler',
      endpoint: endpoints['butler']!,
      methodConnectors: {
        'getChatHistory': _i1.MethodConnector(
          name: 'getChatHistory',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['butler'] as _i3.ButlerEndpoint)
                  .getChatHistory(session),
        ),
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['butler'] as _i3.ButlerEndpoint).sendMessage(
            session,
            params['text'],
          ),
        ),
        'getActiveSuggestions': _i1.MethodConnector(
          name: 'getActiveSuggestions',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['butler'] as _i3.ButlerEndpoint)
                  .getActiveSuggestions(session),
        ),
        'generateDailyBriefing': _i1.MethodConnector(
          name: 'generateDailyBriefing',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['butler'] as _i3.ButlerEndpoint)
                  .generateDailyBriefing(session),
        ),
      },
    );
    connectors['challenge'] = _i1.EndpointConnector(
      name: 'challenge',
      endpoint: endpoints['challenge']!,
      methodConnectors: {
        'getUserChallenges': _i1.MethodConnector(
          name: 'getUserChallenges',
          params: {
            'dummyId': _i1.ParameterDescription(
              name: 'dummyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['challenge'] as _i4.ChallengeEndpoint)
                  .getUserChallenges(
            session,
            params['dummyId'],
          ),
        )
      },
    );
    connectors['community'] = _i1.EndpointConnector(
      name: 'community',
      endpoint: endpoints['community']!,
      methodConnectors: {
        'getGroups': _i1.MethodConnector(
          name: 'getGroups',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['community'] as _i5.CommunityEndpoint)
                  .getGroups(session),
        ),
        'createGroup': _i1.MethodConnector(
          name: 'createGroup',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['community'] as _i5.CommunityEndpoint).createGroup(
            session,
            params['name'],
            params['description'],
          ),
        ),
        'joinGroup': _i1.MethodConnector(
          name: 'joinGroup',
          params: {
            'groupId': _i1.ParameterDescription(
              name: 'groupId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['community'] as _i5.CommunityEndpoint).joinGroup(
            session,
            params['groupId'],
          ),
        ),
        'getMyGroups': _i1.MethodConnector(
          name: 'getMyGroups',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['community'] as _i5.CommunityEndpoint)
                  .getMyGroups(session),
        ),
      },
    );
    connectors['ecoAction'] = _i1.EndpointConnector(
      name: 'ecoAction',
      endpoint: endpoints['ecoAction']!,
      methodConnectors: {
        'getAllActions': _i1.MethodConnector(
          name: 'getAllActions',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ecoAction'] as _i6.EcoActionEndpoint)
                  .getAllActions(session),
        )
      },
    );
    connectors['seed'] = _i1.EndpointConnector(
      name: 'seed',
      endpoint: endpoints['seed']!,
      methodConnectors: {
        'seedData': _i1.MethodConnector(
          name: 'seedData',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['seed'] as _i7.SeedEndpoint).seedData(session),
        )
      },
    );
    connectors['social'] = _i1.EndpointConnector(
      name: 'social',
      endpoint: endpoints['social']!,
      methodConnectors: {
        'getFeed': _i1.MethodConnector(
          name: 'getFeed',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i8.SocialEndpoint).getFeed(session),
        ),
        'getGlobalImpact': _i1.MethodConnector(
          name: 'getGlobalImpact',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i8.SocialEndpoint)
                  .getGlobalImpact(session),
        ),
        'cheerUser': _i1.MethodConnector(
          name: 'cheerUser',
          params: {
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i8.SocialEndpoint).cheerUser(
            session,
            params['targetUserId'],
          ),
        ),
        'nudgeUser': _i1.MethodConnector(
          name: 'nudgeUser',
          params: {
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i8.SocialEndpoint).nudgeUser(
            session,
            params['targetUserId'],
          ),
        ),
      },
    );
    connectors['stats'] = _i1.EndpointConnector(
      name: 'stats',
      endpoint: endpoints['stats']!,
      methodConnectors: {
        'getUserStats': _i1.MethodConnector(
          name: 'getUserStats',
          params: {
            'dummyId': _i1.ParameterDescription(
              name: 'dummyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i9.StatsEndpoint).getUserStats(
            session,
            params['dummyId'],
          ),
        ),
        'getLeaderboard': _i1.MethodConnector(
          name: 'getLeaderboard',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i9.StatsEndpoint).getLeaderboard(session),
        ),
        'getBadges': _i1.MethodConnector(
          name: 'getBadges',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i9.StatsEndpoint).getBadges(session),
        ),
        'updateMonthlyBudget': _i1.MethodConnector(
          name: 'updateMonthlyBudget',
          params: {
            'budget': _i1.ParameterDescription(
              name: 'budget',
              type: _i1.getType<double>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i9.StatsEndpoint).updateMonthlyBudget(
            session,
            params['budget'],
          ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i10.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i12.Endpoints()..initializeEndpoints(server);
  }
}
