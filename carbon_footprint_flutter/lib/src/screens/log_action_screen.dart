import 'package:flutter/material.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart'; // To access global `client`

class LogActionScreen extends StatefulWidget {
  const LogActionScreen({super.key});

  @override
  State<LogActionScreen> createState() => _LogActionScreenState();
}

class _LogActionScreenState extends State<LogActionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  EcoAction? _selectedAction;
  List<EcoAction> _availableActions = [];
  bool _isLoading = true;

  final _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchActions();
  }

  Future<void> _fetchActions() async {
    try {
      final actions = await client.ecoAction.getAllActions();
      if (mounted) {
        setState(() {
          _availableActions = actions;
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
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Log Action')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<EcoAction>(
                value: _selectedAction,
                decoration: const InputDecoration(labelText: 'Action Type'),
                items: _availableActions.map((a) {
                  return DropdownMenuItem(value: a, child: Text(a.name));
                }).toList(),
                onChanged: (val) => setState(() => _selectedAction = val),
                validator: (val) => val == null ? 'Please select an action' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: _selectedAction == null 
                    ? 'Quantity' 
                    : 'Quantity (${_selectedAction!.unit})',
                  hintText: 'e.g. 10',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter quantity';
                  if (double.tryParse(val) == null) return 'Enter a number';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                   if (_formKey.currentState!.validate() && _selectedAction != null) {
                     try {
                        final quantity = double.parse(_quantityController.text);
                        // Calculate CO2 Saved based on factor
                        final saved = quantity * _selectedAction!.co2Factor;

                        final log = ActionLog(
                           userId: 0, // Server will override with real ID
                           actionId: _selectedAction!.id!, 
                           date: DateTime.now(),
                           quantity: quantity,
                           co2Saved: saved, 
                        );

                        if (mounted) {
                          setState(() => _isLoading = true);
                          try {
                            await client.action.logAction(log);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Action saved to Database!')),
                              );
                              Navigator.pop(context, true);
                            }
                          } catch (e) {
                            if (mounted) {
                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          }
                        }
                     } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                     }
                   }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
