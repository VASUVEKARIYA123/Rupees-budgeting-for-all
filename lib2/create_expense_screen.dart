// import 'package:flutter/material.dart';
// import 'models.dart';
//
// class CreateExpenseScreen extends StatefulWidget {
//   final List<String> members;
//
//   CreateExpenseScreen({required this.members});
//
//   @override
//   _CreateExpenseScreenState createState() => _CreateExpenseScreenState();
// }
//
// class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   double _amount = 0.0;
//   String _paidBy = '';
//   Map<String, double> _splits = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _paidBy = widget.members.first;
//     for (var member in widget.members) {
//       _splits[member] = 0.0;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Expense'),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Theme.of(context).primaryColor, Colors.teal.shade100],
//           ),
//         ),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Expense Title',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.title),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an expense title';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _title = value!;
//                         },
//                       ),
//                       SizedBox(height: 16.0),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Amount',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.attach_money),
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an amount';
//                           }
//                           if (double.tryParse(value) == null) {
//                             return 'Please enter a valid number';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _amount = double.parse(value!);
//                         },
//                       ),
//                       SizedBox(height: 16.0),
//                       DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           labelText: 'Paid By',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         value: _paidBy,
//                         items: widget.members.map((String member) {
//                           return DropdownMenuItem<String>(
//                             value: member,
//                             child: Text(member),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _paidBy = newValue!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Split:',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               ...widget.members.map((member) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             member,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 100,
//                           child: TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Amount',
//                               border: OutlineInputBorder(),
//                             ),
//                             keyboardType: TextInputType.number,
//                             initialValue: _splits[member].toString(),
//                             onChanged: (value) {
//                               _splits[member] = double.tryParse(value) ?? 0.0;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Navigator.pop(
//                       context,
//                       Expense(
//                         title: _title,
//                         amount: _amount,
//                         paidBy: _paidBy,
//                         splits: _splits,
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Add Expense'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).hintColor,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'models.dart';

class CreateExpenseScreen extends StatefulWidget {
  final List<String> members;

  CreateExpenseScreen({required this.members});

  @override
  _CreateExpenseScreenState createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  double _amount = 0.0;
  String _paidBy = '';
  Map<String, double> _splits = {};
  bool _isEqualSplit = true;

  @override
  void initState() {
    super.initState();
    _paidBy = widget.members.first;
    for (var member in widget.members) {
      _splits[member] = 0.0;
    }
  }

  void _updateSplits() {
    if (_isEqualSplit) {
      double splitAmount = _amount / widget.members.length;
      for (var member in widget.members) {
        _splits[member] = splitAmount;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Expense'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Expense Title',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an expense title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = double.parse(value!);
                        },
                        onChanged: (value) {
                          _amount = double.tryParse(value) ?? 0.0;
                          _updateSplits();
                        },
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Paid By',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        value: _paidBy,
                        items: widget.members.map((String member) {
                          return DropdownMenuItem<String>(
                            value: member,
                            child: Text(member),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _paidBy = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Split:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text('Equal Split'),
                      Switch(
                        value: _isEqualSplit,
                        onChanged: (value) {
                          setState(() {
                            _isEqualSplit = value;
                            _updateSplits();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              ...widget.members.map((member) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            member,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            initialValue: _splits[member]?.toStringAsFixed(2),
                            enabled: !_isEqualSplit,
                            onChanged: (value) {
                              _splits[member] = double.tryParse(value) ?? 0.0;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isEqualSplit) {
                      _updateSplits();
                    }
                    Navigator.pop(
                      context,
                      Expense(
                        title: _title,
                        amount: _amount,
                        paidBy: _paidBy,
                        splits: _splits,
                      ),
                    );
                  }
                },
                child: Text('Add Expense'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}