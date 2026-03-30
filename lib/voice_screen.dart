import 'package:elevenlabs_agents/elevenlabs_agents.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/agent.dart';
import 'widgets/agent_speaking_indicator.dart';
import 'widgets/status_badge.dart';
import 'widgets/voice_button.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  late final ConversationClient _client;

  @override
  void initState() {
    super.initState();
    _client = ConversationClient(
      callbacks: ConversationCallbacks(
        onConnect: ({required conversationId}) {
          debugPrint('Connected: $conversationId');
        },
        onDisconnect: (details) {
          debugPrint('Disconnected: ${details.reason}');
        },
        onError: (message, [context]) {
          debugPrint('Error: $message');
        },
      ),
    );
  }

  @override
  void dispose() {
    _client.dispose();
    super.dispose();
  }

  Future<bool> _requestMicPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> _startSession() async {
    final hasPermission = await _requestMicPermission();
    if (!hasPermission) return;

    await _client.startSession(agentId: agentId);
  }

  Future<void> _endSession() async {
    await _client.endSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _client,
          builder: (context, child) {
            return Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Voice Agent',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                StatusBadge(status: _client.status),
                const Spacer(),
                AgentSpeakingIndicator(isSpeaking: _client.isSpeaking),
                const Spacer(),
                VoiceButton(
                  status: _client.status,
                  onStart: _startSession,
                  onStop: _endSession,
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
