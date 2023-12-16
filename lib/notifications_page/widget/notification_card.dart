import 'package:flutter/material.dart';

class NotificationCard extends Card {
  NotificationCard(
      {super.key,
      required String userName,
      required String prompt,
      String? object,
      required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Text.rich(
                    TextSpan(
                      text: '$userName ',
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
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        );
}
