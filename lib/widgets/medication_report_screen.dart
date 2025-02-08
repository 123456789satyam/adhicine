import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MedicationReportScreen extends StatelessWidget {
  const MedicationReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTodaysReport(),
                const SizedBox(height: 20),
                _buildDashboardCard(),
                const SizedBox(height: 20),
                _buildHistorySection(),
                const SizedBox(height: 20),
                _buildTimeSection('Morning 08:00 am'),
                _buildMedicationItem(
                  'Calpol 500mg Tablet',
                  'Before Breakfast',
                  'Day 01',
                  status: 'taken',
                ),
                _buildMedicationItem(
                  'Calpol 500mg Tablet',
                  'Before Breakfast',
                  'Day 27',
                  status: 'missed',
                ),
                const SizedBox(height: 20),
                _buildTimeSection('Afternoon 02:00 pm'),
                _buildMedicationItem(
                  'Calpol 500mg Tablet',
                  'After Food',
                  'Day 01',
                  status: 'snoozed',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodaysReport() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Report",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('5', 'Total', Colors.blue),
              _buildStatItem('3', 'Taken', Colors.blue),
              _buildStatItem('1', 'Missed', Colors.blue),
              _buildStatItem('1', 'Snoozed', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, Color color) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Check Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Here you will find everything related\nto your active and past medicines.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 30,
            lineWidth: 8,
            percent: 0.75,
            progressColor: Colors.blue,
            backgroundColor: Colors.grey[200]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Check History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.blue[400],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDayItem('SUN', '1', true),
            _buildDayItem('MON', '2', false),
            _buildDayItem('TUE', '3', false),
            _buildDayItem('WED', '4', false),
            _buildDayItem('THU', '5', false),
            _buildDayItem('FRI', '6', false),
          ],
        ),
      ],
    );
  }

  Widget _buildDayItem(String day, String date, bool isSelected) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[400] : Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMedicationItem(
    String name,
    String timing,
    String day,
    {required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      timing,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      day,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            status == 'taken'
                ? Icons.check_circle_outline
                : status == 'missed'
                    ? Icons.cancel_outlined
                    : Icons.access_time,
            color: status == 'taken'
                ? Colors.green
                : status == 'missed'
                    ? Colors.red
                    : Colors.orange,
          ),
        ],
      ),
    );
  }
}