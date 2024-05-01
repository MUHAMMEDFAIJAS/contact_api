import 'package:contact_app_api/controller/provider_functions.dart';
import 'package:contact_app_api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContacts extends StatelessWidget {
  const AddContacts({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            inputbox(
              controller: provider.nameController,
              icons: Icons.text_format,
              hint: 'Enter Name',
            ),
            inputbox(
              controller: provider.phoneController,
              icons: Icons.phone,
              hint: 'Enter PhoneNumber',
            ),
            inputbox(
              controller: provider.addressController,
              icons: Icons.place,
              hint: 'Enter Address',
            ),
            inputbox(
              controller: provider.emailController,
              icons: Icons.email,
              hint: 'Enter Email',
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                provider.submitContact();
                provider.getAllContacts();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Add Contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget inputbox({
  required TextEditingController controller,
  required IconData icons,
  required String hint,
}) =>
    Container(
      margin: const EdgeInsets.all(15),
      height: 80,
      child: TextField(
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.blue,
          ),
          prefixIcon: Icon(
            icons,
            color: Colors.blue,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
