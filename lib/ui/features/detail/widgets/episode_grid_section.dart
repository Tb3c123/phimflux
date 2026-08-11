import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/episode.dart';
import 'episode_button.dart';
import 'server_tab_button.dart';

/// Server tab selection & compact episode grid section
class EpisodeGridSection extends StatelessWidget {
  final List<ServerData> servers;
  final int selectedServerIndex;
  final int selectedEpisodeIndex;
  final ValueChanged<int> onServerSelected;
  final ValueChanged<int> onEpisodeSelected;

  const EpisodeGridSection({
    super.key,
    required this.servers,
    required this.selectedServerIndex,
    required this.selectedEpisodeIndex,
    required this.onServerSelected,
    required this.onEpisodeSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (servers.isEmpty) return const SizedBox.shrink();
    final currentServer = servers[selectedServerIndex.clamp(0, servers.length - 1)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Nguồn phát:', style: AppTypography.sectionHeader),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 34,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: servers.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return ServerTabButton(
                      serverName: servers[index].serverName,
                      isSelected: selectedServerIndex == index,
                      onTap: () => onServerSelected(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Chọn Tập Phim', style: AppTypography.sectionHeader),
            const SizedBox(width: 8),
            Text(
              '(${currentServer.episodes.length} tập)',
              style: AppTypography.bodySecondary,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxHeight: 220),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cardBackground.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cardBorderDefault),
          ),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(currentServer.episodes.length, (index) {
                final ep = currentServer.episodes[index];
                return EpisodeButton(
                  episodeName: ep.name,
                  isSelected: selectedEpisodeIndex == index,
                  onTap: () => onEpisodeSelected(index),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
