import 'package:flutter/material.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ActionLog> _logs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      // Mock User ID = 0 (ignored by server)
      final logs = await client.action.getActions(0);
      if (mounted) {
        setState(() {
          _logs = logs;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Action History')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _logs.isEmpty
            ? const Center(child: Text('No actions logged yet.'))
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  // If Action relation is null (shouldn't be with include), fallback
                  final name = log.action?.name ?? 'Action #${log.actionId}';
                  final unit = log.action?.unit ?? '';
                  final dateStr = DateFormat.yMMMd().add_jm().format(log.date);

                  return ListTile(
                    leading: const Icon(Icons.history, color: Colors.green),
                    title: Text(name),
                    subtitle: Text(dateStr),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Text('${log.quantity} $unit', style: const TextStyle(fontWeight: FontWeight.bold)),
                         Text('${log.co2Saved.toStringAsFixed(1)} kg CO2', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
