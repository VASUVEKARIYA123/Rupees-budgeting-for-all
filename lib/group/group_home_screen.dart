import 'package:flutter/material.dart';
import 'create_group_screen.dart';
import 'group_details_screen.dart';
import 'models.dart';

class groupHomeScreen extends StatefulWidget {
  const groupHomeScreen({super.key});

  @override
  _groupHomeScreenState createState() => _groupHomeScreenState();
}

class _groupHomeScreenState extends State<groupHomeScreen> {
  List<Group> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor, Colors.blue.shade300],
          ),
        ),
        child: groups.isEmpty
            ? const Center(
          child: Text(
            'No groups yet. Create one!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
        )
            : ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  groups[index].name,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${groups[index].members.length} members',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupDetailsScreen(group: groups[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewGroup();
        },
        tooltip: 'Create New Group',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewGroup() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
    );

    if (result != null) {
      setState(() {
        groups.add(result);
      });
    }
  }
}