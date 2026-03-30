import 'package:flutter/material.dart';

// Replace with your ElevenLabs agent ID from https://elevenlabs.io/agents
const agentId = 'YOUR_AGENT_ID_HERE';

abstract final class AppColors {
  static const background = Color(0xFF0F0F1A);
  static const surface = Color(0xFF1A1A2E);
  static const primary = Color(0xFF6C63FF);
  static const primaryDim = Color(0xFF4A44B2);
  static const success = Color(0xFF00C853);
  static const warning = Color(0xFFFFB300);
  static const error = Color(0xFFFF5252);
  static const text = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFA0A0B8);
  static const border = Color(0xFF2A2A3E);
}

abstract final class AnimationDurations {
  static const pulse = Duration(milliseconds: 1500);
  static const glow = Duration(milliseconds: 2000);
  static const statusTransition = Duration(milliseconds: 300);
}
