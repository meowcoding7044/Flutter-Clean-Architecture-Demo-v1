import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "No Messages Found",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text(
            "Pull down to refresh",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
