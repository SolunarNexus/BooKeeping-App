import 'package:flutter/material.dart';

class NotificationCard extends Card {
  NotificationCard({
    super.key,
    required String friendEmail,
    required String prompt,
    String? object,
    required BuildContext context,
    required VoidCallback onPositive,
    required VoidCallback onNegative,
  }) : super(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text.rich(
                    TextSpan(
                      text: "$friendEmail ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$prompt ',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        TextSpan(text: object)
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: onPositive,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onNegative,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
}
