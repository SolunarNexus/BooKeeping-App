import 'package:flutter/material.dart';

class UserCard extends Card {
  UserCard({super.key, required String userName, required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                // Will be replaced by real avatar image
                child: Icon(Icons.account_circle, size: 80),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, size: 30.0),
                ),
              )
            ],
          ),
        );
}
