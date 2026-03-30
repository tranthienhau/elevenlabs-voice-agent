import 'package:flutter/material.dart';
import '../constants/agent.dart';

class AgentSpeakingIndicator extends StatefulWidget {
  const AgentSpeakingIndicator({super.key, required this.isSpeaking});

  final bool isSpeaking;

  @override
  State<AgentSpeakingIndicator> createState() => _AgentSpeakingIndicatorState();
}

class _AgentSpeakingIndicatorState extends State<AgentSpeakingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  static const _orbSize = 120.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationDurations.glow,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _updateAnimation();
  }

  @override
  void didUpdateWidget(AgentSpeakingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSpeaking != widget.isSpeaking) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    } else {
      _controller.animateTo(0, duration: AnimationDurations.statusTransition);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _orbSize * 1.8,
          height: _orbSize * 1.8,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _opacityAnimation.value,
                        child: Container(
                          width: _orbSize * 1.5,
                          height: _orbSize * 1.5,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedContainer(
                  duration: AnimationDurations.statusTransition,
                  width: _orbSize,
                  height: _orbSize,
                  decoration: BoxDecoration(
                    color: widget.isSpeaking
                        ? AppColors.primary
                        : AppColors.primaryDim,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.isSpeaking ? 'Agent Speaking' : 'Listening',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
