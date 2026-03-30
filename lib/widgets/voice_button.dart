import 'package:elevenlabs_agents/elevenlabs_agents.dart';
import 'package:flutter/material.dart';
import '../constants/agent.dart';

class VoiceButton extends StatefulWidget {
  const VoiceButton({
    super.key,
    required this.status,
    required this.onStart,
    required this.onStop,
  });

  final ConversationStatus status;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  static const _buttonSize = 140.0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: AnimationDurations.pulse,
    );
    _pulseAnimation = Tween(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _updatePulse();
  }

  @override
  void didUpdateWidget(VoiceButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _updatePulse();
    }
  }

  void _updatePulse() {
    if (widget.status == ConversationStatus.connected) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.animateTo(0,
          duration: const Duration(milliseconds: 200));
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  bool get _isActive => widget.status == ConversationStatus.connected;
  bool get _isConnecting => widget.status == ConversationStatus.connecting;

  void _handlePress() {
    if (_isConnecting) return;
    if (_isActive) {
      widget.onStop();
    } else {
      widget.onStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _buttonSize * 1.4,
      height: _buttonSize * 1.4,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isActive)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: _buttonSize + 20,
                      height: _buttonSize + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            GestureDetector(
              onTap: _handlePress,
              child: AnimatedContainer(
                duration: AnimationDurations.statusTransition,
                width: _buttonSize,
                height: _buttonSize,
                decoration: BoxDecoration(
                  color: _isActive ? AppColors.primary : AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isConnecting ? AppColors.warning : AppColors.primary,
                    width: 2,
                  ),
                ),
                child: AnimatedOpacity(
                  duration: AnimationDurations.statusTransition,
                  opacity: _isConnecting ? 0.7 : 1.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isActive ? Icons.stop : Icons.mic,
                        size: 32,
                        color: AppColors.text,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isConnecting
                            ? 'Connecting...'
                            : _isActive
                                ? 'End Session'
                                : 'Start Conversation',
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
