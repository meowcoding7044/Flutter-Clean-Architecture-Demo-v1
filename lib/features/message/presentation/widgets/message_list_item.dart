import 'package:first_flutter_v1/features/message/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageListItem extends StatelessWidget {
  final Data message;

  const MessageListItem({super.key, required this.message});

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "No date";
    try {
      // Assuming the date is in UTC, convert to local time for display.
      final dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat.yMMMd().add_jm().format(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(message.content ?? "No Content"),
        subtitle: Text(_formatDate(message.createdAt)),
        trailing: Text(
          // Show a shorter, more readable part of the user ID.
          "User: ${message.userId?.substring(0, 8)}...",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
