import 'package:flutter/material.dart';
import 'package:webb_ui/webb_ui.dart';

class WebbUIDashboardPage extends StatelessWidget {
  const WebbUIDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacingGrid.spacing(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats Row
          WebbUIResponsiveGrid(
            children: [
              _buildStatCard(
                context,
                title: 'Total Users',
                value: '2,847',
                change: '+12%',
                isPositive: true,
                icon: Icons.people_outline,
                color: context.colorPalette.primary,
              ),
              _buildStatCard(
                context,
                title: 'Revenue',
                value: '\$24,500',
                change: '+8%',
                isPositive: true,
                icon: Icons.attach_money,
                color: context.colorPalette.success,
              ),
              _buildStatCard(
                context,
                title: 'Conversion Rate',
                value: '3.2%',
                change: '-2%',
                isPositive: false,
                icon: Icons.trending_up,
                color: context.colorPalette.warning,
              ),
              _buildStatCard(
                context,
                title: 'Active Sessions',
                value: '1,243',
                change: '+5%',
                isPositive: true,
                icon: Icons.visibility,
                color: context.colorPalette.info,
              ),
            ],
          ),

          SizedBox(height: context.spacingGrid.spacing(3)),

          // Charts Section
          Row(
            children: [
              Expanded(
                flex: 2,
                child: WebbUICard(
                  elevated: true,
                  child: Padding(
                    padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Revenue Trends',
                          style: context.typography.headlineMedium,
                        ),
                        SizedBox(height: context.spacingGrid.spacing(2)),
                        SizedBox(
                          height: 300,
                          child: WebbUIChart(
                            series: [
                              ChartSeries(
                                name: '2023',
                                data: [
                                  const ChartData(1, 12000),
                                  const ChartData(2, 19000),
                                  const ChartData(3, 15000),
                                  const ChartData(4, 22000),
                                  const ChartData(5, 18000),
                                  const ChartData(6, 25000),
                                ],
                                color: context.colorPalette.primary,
                                chartType: ChartType.line,
                              ),
                              ChartSeries(
                                name: '2024',
                                data: [
                                  const ChartData(1, 15000),
                                  const ChartData(2, 22000),
                                  const ChartData(3, 19000),
                                  const ChartData(4, 26000),
                                  const ChartData(5, 23000),
                                  const ChartData(6, 29000),
                                ],
                                color: context.colorPalette.success,
                                chartType: ChartType.line,
                              ),
                            ],
                            chartType: ChartType.line,
                            config: const ChartConfig(
                              showGrid: true,
                              legendPosition: LegendPosition.top,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.spacingGrid.spacing(3)),
              Expanded(
                flex: 1,
                child: WebbUICard(
                  elevated: true,
                  child: Padding(
                    padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Distribution',
                          style: context.typography.headlineMedium,
                        ),
                        SizedBox(height: context.spacingGrid.spacing(2)),
                        SizedBox(
                          height: 300,
                          child: WebbUIChart(
                            series: [
                              ChartSeries(
                                name: 'Distribution',
                                data: [
                                  const ChartData(label: 'Mobile', 1, 45),
                                  const ChartData(label: 'Desktop', 1, 35),
                                  const ChartData(label: 'Tablet', 1, 20),
                                ],
                                color: context.colorPalette.primary,
                                chartType: ChartType.pie,
                              ),
                            ],
                            chartType: ChartType.pie,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
  }) {
    return WebbUICard(
      elevated: true,
      child: Padding(
        padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(context.spacingGrid.spacing(1)),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                WebbUIBadge(
                  content: change,
                  colorType: isPositive
                      ? WebbUIBadgeColorType.success
                      : WebbUIBadgeColorType.error,
                  size: WebbUIBadgeSize.small,
                ),
              ],
            ),
            SizedBox(height: context.spacingGrid.spacing(1)),
            Text(
              value,
              style: context.typography.headlineLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: context.typography.bodyMedium.copyWith(
                color: context.colorPalette.neutralDark.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
