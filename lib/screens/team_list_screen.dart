import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team.dart';
import '../features/auth/data/auth_repository.dart';

class TeamListScreen extends ConsumerStatefulWidget {
  const TeamListScreen({super.key});

  @override
  ConsumerState<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends ConsumerState<TeamListScreen> {
  List<Team> _teams = [
    Team(id: '1', name: 'Study Group Alpha', hostId: 'user1', createdAt: DateTime.now()),
    Team(id: '2', name: 'Math Masters', hostId: 'user2', createdAt: DateTime.now()),
    Team(id: '3', name: 'Science Squad', hostId: 'user3', createdAt: DateTime.now()),
  ];

  void _showCreateTeamDialog() {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Team'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Team Name',
            hintText: 'Enter team name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                _addTeam(nameController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _addTeam(String teamName) {
    final newTeam = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: teamName,
      hostId: 'current_user_id', // TODO: Get actual user ID
      createdAt: DateTime.now(),
    );
    
    setState(() {
      _teams = [..._teams, newTeam]; // Create a new list to ensure it's modifiable
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Team "$teamName" created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Teams'),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _teams.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No teams yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Create or join a team to get started!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _teams.length,
              itemBuilder: (context, index) {
                final team = _teams[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        team.name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      team.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Created ${_formatDate(team.createdAt)}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to team details
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening ${team.name}...')),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _showCreateTeamDialog,
            icon: const Icon(Icons.add),
            label: const Text('Create Team'),
            heroTag: 'create',
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () {
              // TODO: Show join team dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Join team feature coming soon!')),
              );
            },
            icon: const Icon(Icons.group_add),
            label: const Text('Join Team'),
            heroTag: 'join',
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
