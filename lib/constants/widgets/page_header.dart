import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageHeader extends StatelessWidget {
  final String pageName;
  const PageHeader({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
            Text(
              pageName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryContainer,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
