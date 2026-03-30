# ElevenLabs Voice Agent

Flutter POC wrapping an ElevenLabs conversational AI agent with real-time voice communication.

## Tech Stack

- Flutter, Dart
- `elevenlabs_agents` - ElevenLabs Conversational AI SDK (LiveKit/WebRTC transport)
- `permission_handler` - Cross-platform microphone permissions

## Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Set your ElevenLabs Agent ID in `lib/constants/agent.dart`:
```dart
const agentId = 'your_agent_id_here';
```

Get your Agent ID from [ElevenLabs Agents Dashboard](https://elevenlabs.io/agents).

3. Run:
```bash
flutter run
```

## Features

- Real-time voice conversations with ElevenLabs AI agents
- Cross-platform microphone permission handling (iOS/Android)
- Visual feedback: connection status badge, speaking/listening indicator
- Animated pulse effects for active connection and agent speaking state
- Dark theme UI

## Project Structure

```
lib/
  main.dart                           - App entry point
  voice_screen.dart                   - Main voice conversation screen
  constants/
    agent.dart                        - Agent ID, colors, animation config
  widgets/
    status_badge.dart                 - Connection status indicator
    agent_speaking_indicator.dart     - Speaking vs listening visual
    voice_button.dart                 - Start/stop button with pulse animation
```

## Notes

- iOS: microphone permission configured via `NSMicrophoneUsageDescription` in Info.plist
- Android: uses `RECORD_AUDIO` permission with runtime request via permission_handler
