import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DashboardHighlights extends StatelessWidget {
  const DashboardHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashboardHighlightItem(
          mainText: "24",
          subText: "Total Registered Members",
          mainColor: Theme.of(context).colorScheme.onPrimary,
          subColor: Theme.of(context).colorScheme.onPrimary,
          bgColor: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(width: 20),
        DashboardHighlightItem(
          flexValue: 2,
          mainText: "GH¢ 14,305.50",
          mainColor: Theme.of(context).colorScheme.tertiary,
          subText: "Total Revenue for This Month",
          subColor: Theme.of(context).colorScheme.tertiary,
          bgColor: Theme.of(context).colorScheme.secondary.withOpacity(0.65),
        ),
        const SizedBox(width: 20),
        DashboardHighlightItem(
          mainText: "18",
          mainColor: Theme.of(context).colorScheme.tertiary,
          subText: "Average Attendance for Midweek Service",
          subColor: Theme.of(context).colorScheme.tertiary,
          bgColor: Colors.white,
        ),
        const SizedBox(width: 20),
        DashboardHighlightItem(
          mainText: "14",
          mainColor: Theme.of(context).colorScheme.tertiary,
          subText: "Average Attendance for Sunday Service",
          subColor: Theme.of(context).colorScheme.tertiary,
          bgColor: Colors.white,
        ),
      ],
    );
  }
}

class DashboardHighlightItem extends StatelessWidget {
  final Color bgColor;
  final Color mainColor;
  final Color subColor;
  final String mainText;
  final String subText;
  final int? flexValue;

  const DashboardHighlightItem({
    super.key,
    required this.mainText,
    required this.subText,
    required this.bgColor,
    required this.mainColor,
    required this.subColor,
    this.flexValue = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue!,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              mainText,
              style: TextStyle(
                fontSize: 40,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 32,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            AutoSizeText(
              subText,
              style: TextStyle(
                fontSize: 14,
                color: subColor,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 11,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}
