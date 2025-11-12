import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatelessWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .15),
          Icon(Icons.cloud_off, color: Colors.red, size: 50),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'We re unable to show result. \nPlease check your network\nconnection.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .15),
          ElevatedButton(
            onPressed: onPress,
            child: Center(
              child: Text("RETRY", style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
        ],
      ),
    );
  }
}
