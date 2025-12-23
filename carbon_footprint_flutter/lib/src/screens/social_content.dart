import 'package:flutter/material.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart'; // To access global `client`
import '../widgets/glass_card.dart';

class SocialContent extends StatefulWidget {
  const SocialContent({super.key});

  @override
  State<SocialContent> createState() => _SocialContentState();
}

class _SocialContentState extends State<SocialContent> {
  List<UserProfile> _leaderboard = [];
  List<SocialPost> _feed = [];
  List<CommunityGroup> _groups = [];
  double _globalImpact = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      final leaderboard = await client.stats.getLeaderboard();
      final feed = await client.social.getFeed();
      final impact = await client.social.getGlobalImpact();
      final groups = await client.community.getGroups();
      if (mounted) {
        setState(() {
          _leaderboard = leaderboard;
          _feed = feed;
          _globalImpact = impact;
          _groups = groups;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            // labelColor: Theme.of(context).primaryColor,
            // unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey,
            tabs: const [
              Tab(text: 'Feed', icon: Icon(Icons.forum_outlined)),
              Tab(text: 'Leaderboard', icon: Icon(Icons.leaderboard_outlined)),
              Tab(text: 'Communities', icon: Icon(Icons.groups_outlined)),
            ],
          ),
          _buildGlobalImpactBanner(),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    _buildFeedView(),
                    _buildLeaderboardView(),
                    _buildCommunitiesView(),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalImpactBanner() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          const Text('GLOBAL IMPACT', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 8),
          const Text('across our global community!', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 12),
          Text('${_globalImpact.toStringAsFixed(1)} kg CO2 SAVED', 
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1)),
        ],
      ),
    );
  }

  Widget _buildFeedView() {
    if (_feed.isEmpty) {
      return const Center(child: Text('Nothing here yet. Be the first to log an action!'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _feed.length,
      itemBuilder: (context, index) {
        final post = _feed[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            opacity: 0.03,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person, 
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Theme.of(context).primaryColor,
                ),
              ),
              title: Text(post.userName ?? 'Anonymous User', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.content, style: const TextStyle(fontSize: 14, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(post.timestamp.toString().split('.')[0], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardView() {
    if (_leaderboard.isEmpty) {
      return const Center(child: Text('No profiles found.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _leaderboard.length,
      separatorBuilder: (c, i) => const Divider(),
      itemBuilder: (context, index) {
        final user = _leaderboard[index];
        final isMe = user.userId == sessionManager.signedInUser?.id;

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: isMe ? Colors.green : Theme.of(context).cardColor,
            child: Text('${index + 1}', style: TextStyle(color: isMe ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color)),
          ),
          title: Text(isMe ? 'You (${user.userName ?? "Anonymous"})' : (user.userName ?? 'User #${user.userId}')),
          subtitle: Text('Level ${user.level} • Joined ${user.joinedDate.toString().split(" ")[0]}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMe) ...[
                IconButton(
                  icon: const Icon(Icons.celebration_outlined, color: Colors.orange, size: 20),
                  onPressed: () => _cheerUser(user.userId),
                  tooltip: 'Cheer',
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined, color: Colors.blueGrey, size: 20),
                  onPressed: () => _nudgeUser(user.userId),
                  tooltip: 'Nudge',
                ),
              ],
              const SizedBox(width: 8),
              Text(
                '${user.ecoScore}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
            ],
          ),
          tileColor: isMe ? Colors.green.withValues(alpha: 0.1) : null,
        );
      },
    );
  }

  Widget _buildCommunitiesView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => _showCreateGroupDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Create Community'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Expanded(
          child: _groups.isEmpty
              ? const Center(child: Text('No communities yet. Be a pioneer!'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _groups.length,
                  itemBuilder: (context, index) {
                    final group = _groups[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GlassCard(
                        opacity: 0.05,
                        child: ListTile(
                          title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(group.description),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${group.memberCount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const Text('members', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                          onTap: () => _joinGroup(group.id!),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showCreateGroupDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Community'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await client.community.createGroup(nameController.text, descController.text);
                if (mounted) {
                  Navigator.pop(context);
                  _fetchData();
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _joinGroup(int groupId) async {
    try {
      await client.community.joinGroup(groupId);
      if (mounted) {
        final userName = sessionManager.signedInUser?.userName ?? "Friend";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome to the community, $userName!')));
        _fetchData();
      }
    } catch (e) {
       if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _cheerUser(int userId) async {
    try {
      await client.social.cheerUser(userId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Heavens! A formal Cheer has been sent.')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _nudgeUser(int userId) async {
    try {
      await client.social.nudgeUser(userId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The Butler will deliver your Nudge immediately.')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
