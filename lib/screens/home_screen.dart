import 'package:contact_app_api/controller/provider_functions.dart';
import 'package:contact_app_api/screens/add_contact_screen.dart';
import 'package:contact_app_api/screens/contact_details_screens.dart';
import 'package:contact_app_api/screens/update_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);
    provider.getAllContacts();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ContactProvider>(builder: (context, pro, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  pro.searchContacts(value);
                },
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'Search for Contacts',
                  hintStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
            Consumer<ContactProvider>(builder: (context, pro, child) {
              final contactsToDisplay = pro.filteredContacts.isNotEmpty
                  ? pro.filteredContacts
                  : pro.contacts;
              return Expanded(
                child: contactsToDisplay.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: contactsToDisplay.length,
                        itemBuilder: (context, index) {
                          final person = contactsToDisplay[index];
                          final name = person.name;
                          final phone = person.phone;
                          final address = person.address;
                          final id = person.sId;
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ContactDetailScreen(
                                    name: name.toString(),
                                    phone: phone.toString(),
                                    address: address.toString(),
                                    contactId: id.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.person_2,
                                            color: Colors.blue,
                                            size: 40,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            name.toString().toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateContactScreen(
                                                    contactId: person,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              pro.deleteContacts(person.sId!);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              );
            }),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AddContacts()));
          provider.getAllContacts();
        },
        backgroundColor: Colors.blue,
        child: const Text(
          '+',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
