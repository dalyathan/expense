import 'package:contacts_service/contacts_service.dart';
import 'package:credit_card/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state/add_expense/to.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  Future<List<Contact>> myContacts =
      ContactsService.getContacts(withThumbnails: false);
  late AddExpenseTo addExpenseTo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      addExpenseTo = Provider.of<AddExpenseTo>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyTheme.darkBlue,
            title: Text('Select Contact',
                style: GoogleFonts.sora(color: Colors.white)),
          ),
          body: FutureBuilder<List<Contact>>(
            future: myContacts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact c = snapshot.data!.elementAt(index);
                    return ListTile(
                      onTap: () {
                        addExpenseTo.setTo(c);
                        Navigator.pop(context);
                      },
                      leading: (c.avatar != null && c.avatar!.isNotEmpty)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(c.avatar!))
                          : CircleAvatar(child: Text(c.initials())),
                      title: Text(c.displayName ?? ""),
                    );
                  },
                );
              }
              return const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: MyTheme.darkBlue,
                  ),
                ),
              );
            },
          )),
    );
  }
}
