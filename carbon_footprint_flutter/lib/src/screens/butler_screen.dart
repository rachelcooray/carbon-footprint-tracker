import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
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
  final ImagePicker _picker = ImagePicker();
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
    // Optimistic UI update (append user message)
    setState(() {
      _messages.add(ButlerMessage(
        userId: 0,
        text: text,
        isFromButler: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();

    // Prepare placeholder for Butler response
    final butlerResponsePlaceholder = ButlerMessage(
      userId: 0,
      text: "", // Start empty
      isFromButler: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(butlerResponsePlaceholder);
    });
    _scrollToBottom();

    try {
      final stream = client.butler.chatStream(text);
      
      await for (final chunk in stream) {
        setState(() {
          butlerResponsePlaceholder.text += chunk;
        });
        _scrollToBottom();
      }
      
      // Once stream is done, we could fetch full history to ensure sync, 
      // but streaming updates should be enough for immediate feedback.
      // _fetchHistory(); 
    } catch (e) {
      if (mounted) {
        // Remove the placeholder if it failed completely or show error
        setState(() {
          butlerResponsePlaceholder.text = "I apologize, but I lost my connection. ($e)";
        });
      }
    }
  }

  Future<void> _pickAndAnalyzeImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, maxWidth: 1024, maxHeight: 1024, imageQuality: 85);
      if (image == null) return;

      // Optimistic UI
      setState(() {
        _messages.add(ButlerMessage(
          userId: 0,
          text: "📷 Analyzing image...",
          isFromButler: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();

      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await client.butler.analyzeImage(base64Image);

      setState(() {
         _messages.add(ButlerMessage(
          userId: 0,
          text: response,
          isFromButler: true,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
      
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error analyzing image: $e')));
      }
    }
  }

  Future<void> _pickAndAnalyzePDF() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Use any to ensure web compatibility
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      
      // Check if we have bytes first (Web) or fallback to path (Mobile)
      List<int> fileBytes;
      if (file.bytes != null) {
        // Web or when bytes are loaded
        fileBytes = file.bytes!;
      } else if (file.path != null) {
         // Mobile: Read from file path
        final ioFile = File(file.path!);
        fileBytes = await ioFile.readAsBytes();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read file data')),
        );
        return;
      }

      // Optimistic UI
      setState(() {
        _messages.add(ButlerMessage(
          userId: 0,
          text: "📄 Analyzing document: ${file.name}...",
          isFromButler: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();

      final base64PDF = base64Encode(fileBytes);
      final response = await client.butler.analyzeImage(base64PDF);

      setState(() {
        _messages.add(ButlerMessage(
          userId: 0,
          text: response,
          isFromButler: true,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error analyzing PDF: $e')),
        );
      }
    }
  }

  void _showImageSourceModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassCard(
        blur: 20,
        opacity: 0.1,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Source",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    icon: Icons.camera_alt_rounded,
                    label: "Camera",
                    onTap: () {
                      Navigator.pop(context);
                      _pickAndAnalyzeImage(ImageSource.camera);
                    },
                  ),
                  _buildSourceOption(
                    icon: Icons.photo_library_rounded,
                    label: "Gallery",
                    onTap: () {
                      Navigator.pop(context);
                      _pickAndAnalyzeImage(ImageSource.gallery);
                    },
                  ),
                  _buildSourceOption(
                    icon: Icons.description_rounded,
                    label: "Files",
                    onTap: () {
                      Navigator.pop(context);
                      _pickAndAnalyzePDF();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
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
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark ? [
            const Color(0xFF0F1710),
            const Color(0xFF050505),
          ] : [
            theme.colorScheme.surface,
            theme.colorScheme.primary.withValues(alpha: 0.03),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1), 
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05), blurRadius: 20, spreadRadius: 10),
              ],
            ),
            child: Icon(Icons.auto_awesome_rounded, size: 64, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 32),
          Text('Your Butler is ready.', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('How may I assist your eco-journey today?', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ButlerMessage message, bool isDark) {
    final theme = Theme.of(context);
    final isButler = message.isFromButler;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: isButler ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isButler) ...[
             CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(Icons.auto_awesome_rounded, size: 18, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isButler 
                  ? (isDark ? const Color(0xFF1E261F) : Colors.white)
                  : theme.colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isButler ? 4 : 24),
                  topRight: Radius.circular(isButler ? 24 : 4),
                  bottomLeft: const Radius.circular(24),
                  bottomRight: const Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
                border: isButler ? Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.05)) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isButler ? theme.colorScheme.onSurface : theme.colorScheme.onPrimary,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat.jm().format(message.timestamp.toLocal()),
                    style: TextStyle(
                      fontSize: 10, 
                      color: isButler ? Colors.grey : theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isButler) ...[
            const SizedBox(width: 12),
             CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: Icon(Icons.person_rounded, size: 18, color: theme.colorScheme.secondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Message Butler...',
                hintStyle: TextStyle(fontSize: 15, color: theme.hintColor.withValues(alpha: 0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Container(
             height: 48,
             width: 48,
             decoration: BoxDecoration(
               color: theme.colorScheme.secondaryContainer,
               shape: BoxShape.circle,
             ),
             child: IconButton(
               onPressed: _showImageSourceModal,
               icon: Icon(Icons.attach_file, color: theme.colorScheme.onSecondaryContainer, size: 22),
               tooltip: 'Snap & Log',
             ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
