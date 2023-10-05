import 'package:flutter/material.dart';

class LoginScreenTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'ProcrastiLess',
          style: Theme.of(context)
              .textTheme
              .apply(fontSizeFactor: 2.2, fontSizeDelta: .3)
              .headlineSmall,
        ),
        SizedBox(
          height: 40,
        ),
        RichText(
            text: TextSpan(
          text: 'A better ',
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
              text: 'FUN',
              style: Theme.of(context)
                  .textTheme
                  .apply(fontSizeFactor: 1.3, fontSizeDelta: 4.2)
                  .bodyMedium,
            ),
            TextSpan(
              text: ' way to get things done',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        )),
        SizedBox(
          height: 15,
        ),
        RichText(
          text: TextSpan(
            text: 'The change in mindset starts with you',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
