import 'package:flutter/material.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart';
import '../widgets/glass_card.dart';

class ButlerScreen extends StatefulWidget {
  const ButlerScreen({super.key});

  @override
  State<ButlerScreen> createState() => _ButlerScreenState();
}

class _ButlerScreenState extends State<ButlerScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ButlerMessage> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      final history = await client.butler.getChatHistory();
      if (mounted) {
        setState(() {
          _messages = history;
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    // Optimistic UI update (append to end for standard list)
    setState(() {
      _messages.add(ButlerMessage(
        userId: 0,
        text: text,
        isFromButler: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();

    try {
      await client.butler.sendMessage(text);
      await _fetchHistory(); // Refresh to get butler response
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF121212) : const Color(0xFFF5F7F5),
      child: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageBubble(_messages[index], isDark);
                        },
                      ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
     return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.blueGrey.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.face_retouching_natural, size: 60, color: Colors.blueGrey),
          ),
          const SizedBox(height: 24),
          const Text('I am at your service.', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
          const SizedBox(height: 8),
          Text('How may I assist your eco-journey today?', style: TextStyle(color: Theme.of(context).hintColor)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ButlerMessage message, bool isDark) {
    final isButler = message.isFromButler;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isButler ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isButler) ...[
             CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueGrey.shade800,
              child: const Icon(Icons.face_retouching_natural, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: isButler 
                  ? (isDark ? Colors.blueGrey.shade900 : Colors.white)
                  : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isButler ? 0 : 20),
                  bottomRight: Radius.circular(isButler ? 20 : 0),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2)),
                ],
                border: isButler ? Border.all(color: Colors.blueGrey.withValues(alpha: 0.1)) : null,
              ),
              child: Column(
                crossAxisAlignment: isButler ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isButler ? (isDark ? Colors.white : Colors.black87) : Colors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 10, 
                      color: isButler ? Colors.grey : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isButler) ...[
            const SizedBox(width: 8),
             CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              child: const Icon(Icons.person, size: 18, color: Colors.green),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Summon your Butler...',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).hintColor.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
