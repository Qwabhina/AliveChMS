import 'package:flutter/material.dart';

class AppTabView extends StatelessWidget {
  const AppTabView({
    super.key,
    required this.tabs,
    required this.tabWidgets,
  });

  final List<Tab> tabs;
  final List<Widget> tabWidgets;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.center,
            indicator: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            tabs: tabs,
          ),
          // const SizedBox(height: 16),
          SizedBox(
            // height: double.maxFinite,
            height: MediaQuery.of(context).size.height - 240,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
              child: TabBarView(
                physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast,
                ),
                children: tabWidgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
