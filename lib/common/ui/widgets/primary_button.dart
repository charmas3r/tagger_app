import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.buttonText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        width: double.infinity,
        child: MaterialButton(
          onPressed: () => {
            onTap()
          },
          color: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child:
          const Text('Save Plant', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

}