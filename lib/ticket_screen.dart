// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api/system_api.dart';
import 'localizations/localizations.dart';

class TicketsScreen extends StatefulWidget {
  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final SystemApi _api = SystemApi();
  List<String> _tickets = [];

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    final List<String> tickets = await _api.getTickets();

    setState(() {
      _tickets = tickets;
    });

    if (tickets.isEmpty) {
      // No tickets to show, navigate to SendTicketScreen
      GoRouter.of(context).push('/sendticket');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: ListView.builder(
        itemCount: _tickets.length,
        itemBuilder: (context, index) {
          final ticket = _tickets[index];
          return ListTile(
            title: Text(ticket),
            onTap: () {
              // Implement the logic to handle tapping on a ticket
            },
          );
        },
      ),
    );
  }
}

class SendTicketScreen extends StatelessWidget {
  final SystemApi _api = SystemApi();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context).getTranslate('sendticket')}: '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context).getTranslate('subject')}: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                hintText:
                    '${AppLocalizations.of(context).getTranslate('subject')}: ',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '${AppLocalizations.of(context).getTranslate('description')}: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText:
                    '${AppLocalizations.of(context).getTranslate('description')}: ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final String subject = _subjectController.text;
                final String description = _descriptionController.text;

                // Send the ticket
                final bool isTicketSent =
                    await _api.sendTicket(subject, description, 'general');

                if (isTicketSent) {
                  // Ticket sent successfully, navigate to the TicketsScreen
                  GoRouter.of(context).push('/tickets');
                } else {
                  // Failed to send ticket, show an error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to send ticket.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(
                  '${AppLocalizations.of(context).getTranslate('sendticket')}: '),
            ),
          ],
        ),
      ),
    );
  }
}
