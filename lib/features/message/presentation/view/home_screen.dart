import 'package:first_flutter_v1/core/config/routes_name.dart';
import 'package:first_flutter_v1/core/di/injection_container.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:first_flutter_v1/features/message/presentation/bloc/bloc.dart';
import 'package:first_flutter_v1/features/message/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showLogoutConfirmationDialog(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => sl<MessageBloc>()..add(MessagesFetch()),
        child: const MessageView(), // Changed to a separate widget for clarity
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) async {
    final bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      await sl<SessionController>().clearSession();
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      );
    }
  }
}
