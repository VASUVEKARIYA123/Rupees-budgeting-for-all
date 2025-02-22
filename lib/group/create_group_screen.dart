import 'package:flutter/material.dart';
import 'models.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _groupName = '';
  final List<String> _members = [];
  final TextEditingController _memberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Group'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Group Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.group),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a group name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _groupName = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Members:',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8.0),
                      ..._members.asMap().entries.map((entry) {
                        int idx = entry.key;
                        String member = entry.value;
                        return Card(
                          color: Colors.teal.shade50,
                          child: ListTile(
                            title: Text(member),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _members.removeAt(idx);
                                });
                              },
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _memberController,
                              decoration: const InputDecoration(
                                labelText: 'Add Member',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_add),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_memberController.text.isNotEmpty) {
                                setState(() {
                                  _members.add(_memberController.text);
                                  _memberController.clear();
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.orangeAccent,
                            ),
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _members.isNotEmpty) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      Group(name: _groupName, members: _members),
                    );
                  } else if (_members.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please add at least one member')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create Group'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}