import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/homeScreen/home_screen4.dart';
import 'package:myapp/initBalance/initBalance_service.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/textfield.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[900]!],
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Ruppes',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Add Balance',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: CustomTextField(
                    hint: "Enter Amount",
                    label: "Amount",
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Add Balance",
              onPressed: _addBalance,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
  Future<void> _addBalance() async {
    // Implement balance addition logic here

    final stat = await addIntiBalance(_balanceController.text);
    if (stat) {
      log("Added Balance Successfully");
      goToHome(context);
    } else {
      log("Something went wrong");
    }
  }
}
