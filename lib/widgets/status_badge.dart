import 'package:elevenlabs_agents/elevenlabs_agents.dart';
import 'package:flutter/material.dart';
import '../constants/agent.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ConversationStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      ConversationStatus.disconnected => ('Ready', AppColors.textSecondary),
      ConversationStatus.connecting => ('Connecting...', AppColors.warning),
      ConversationStatus.connected => ('Connected', AppColors.success),
      ConversationStatus.disconnecting => ('Disconnecting...', AppColors.warning),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
