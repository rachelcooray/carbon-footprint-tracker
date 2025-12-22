import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart'; // To access global `client`
import '../widgets/glass_card.dart';

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
      appBar: AppBar(title: const Text('New Entry')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What did you achieve?', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Every small action leads to a cleaner world.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 32),
                GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      DropdownButtonFormField<EcoAction>(
                        value: _selectedAction,
                        decoration: InputDecoration(
                          labelText: 'Action Type',
                          prefixIcon: const Icon(Icons.category_outlined, size: 20),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        ),
                        items: _availableActions.map((a) {
                          return DropdownMenuItem(value: a, child: Text(a.name));
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedAction = val),
                        validator: (val) => val == null ? 'Please select an action' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: _selectedAction == null 
                            ? 'Quantity' 
                            : 'Quantity (${_selectedAction!.unit})',
                          prefixIcon: const Icon(Icons.numbers_rounded, size: 20),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          hintText: 'e.g. 10',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Enter quantity';
                          if (double.tryParse(val) == null) return 'Enter a number';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                     if (_formKey.currentState!.validate() && _selectedAction != null) {
                       try {
                          final quantity = double.parse(_quantityController.text);
                          final saved = quantity * _selectedAction!.co2Factor;

                          final log = ActionLog(
                             userId: 0,
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
                                  const SnackBar(content: Text('Action archived successfully!')),
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
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('ARCHIVE ACTION', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
