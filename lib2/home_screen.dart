import 'package:flutter/material.dart';
import 'create_group_screen.dart';
import 'group_details_screen.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Group> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).primaryColor, Colors.teal.shade100],
          ),
        ),
        child: groups.isEmpty
            ? Center(
          child: Text(
            'No groups yet. Create one!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
            : ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  groups[index].name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  '${groups[index].members.length} members',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
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
        child: Icon(Icons.add),
        tooltip: 'Create New Group',
      ),
    );
  }

  void _createNewGroup() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateGroupScreen()),
    );

    if (result != null) {
      setState(() {
        groups.add(result);
      });
    }
  }
}