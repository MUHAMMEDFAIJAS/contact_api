// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:contact_app_api/controller/provider_functions.dart';
import 'package:contact_app_api/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateContactScreen extends StatefulWidget {
  final contactId;

  const UpdateContactScreen({super.key, required this.contactId});

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<ContactProvider>(context, listen: false);
    final ContactModel contact = widget.contactId as ContactModel;
    provider.nameController.text = contact.name ?? '';
    provider.phoneController.text = contact.phone?.toString() ?? '';
    provider.addressController.text = contact.address ?? '';
    provider.emailController.text = contact.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<ContactProvider>(
            builder: (context, provider, child) {
              return Column(
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
                      provider.updateContact(widget.contactId);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Update Contacts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
