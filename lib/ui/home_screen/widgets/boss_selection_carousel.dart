import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../ui/core/ui/liquid_glass_box.dart';
import '../../static_scene/widgets/static_scene_widget.dart';
import '../view_models/add_exam_page_view_model.dart';
import '../view_models/home_screen_view_model.dart';

class BossSelectionCarousel extends StatefulWidget {
  const BossSelectionCarousel({
    super.key,
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<BossSelectionCarousel> createState() => _BossSelectionCarouselState();
}

class _BossSelectionCarouselState extends State<BossSelectionCarousel> {
  late final CarouselController _carouselController;

  @override
  void initState() {
    widget.viewModel.loadCommand.execute();

    _carouselController = CarouselController(initialItem: 1);
    _carouselController.listen((_) {
      final List<int> weights = widget.viewModel.carouselFlexWeights;
      final int totalWeight = weights.reduce((int a, int b) => a + b);
      final double dimension = _carouselController.position.viewportDimension;

      var index =
          _carouselController.offset /
          (dimension * (weights.first / totalWeight));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.viewModel.setSelectedBossIndexCommand.execute(index.round());
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.loadCommand.isExecuting,
      builder: (context, isExecuting, child) {
        return isExecuting
            ? Center(child: CircularProgressIndicator())
            : child!;
      },
      child: ValueListenableBuilder(
        valueListenable: widget.viewModel.selectedBossIndex,
        builder: (context, selectedBossIndex, _) {
          return Row(
            children: [
              IconButton(
                onPressed:
                    widget.viewModel.canCarouselMoveLeft
                        ? _onMoveLeftPressed
                        : null,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ValueListenableBuilder(
                    valueListenable: widget.viewModel.bosses,
                    builder: (context, bosses, _) {
                      return CarouselView.weighted(
                        controller: _carouselController,
                        onTap: _onBossTap,
                        backgroundColor: Colors.transparent,
                        enableSplash: false,
                        flexWeights: widget.viewModel.carouselFlexWeights,
                        itemSnapping: true,
                        scrollDirection: Axis.horizontal,
                        shape: RoundedRectangleBorder(),
                        children:
                            bosses.asMap().entries.map((entry) {
                              return _AddExamBossItem(
                                boss: entry.value,
                                selected: entry.key == selectedBossIndex,
                              );
                            }).toList(),
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    widget.viewModel.canCarouselMoveRight
                        ? _onMoveRightPressed
                        : null,
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onMoveLeftPressed() => _carouselController.animateToItem(
    widget.viewModel.selectedBossIndex.value - 1,
  );

  void _onMoveRightPressed() => _carouselController.animateToItem(
    widget.viewModel.selectedBossIndex.value + 1,
  );

  void _onBossTap(int index) => _carouselController.animateToItem(index);

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }
}

class _AddExamBossItem extends StatelessWidget {
  const _AddExamBossItem({required this.boss, required this.selected});

  final Boss boss;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 64.0),
          child: LiquidGlassBox(
            alpha: selected ? 96 : 56,
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    boss.ects % 1 == 0
                        ? '${boss.ects.toInt()}'
                        : '${boss.ects}',
                    style:
                        selected
                            ? Theme.of(context).textTheme.headlineMedium
                            : Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'ECTS',
                    style:
                        selected
                            ? Theme.of(context).textTheme.labelMedium
                            : Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Durations.medium1,
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.only(bottom: 72.0, top: selected ? 0.0 : 64.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 2
                  ? SizedBox()
                  : Opacity(
                    opacity: selected ? 1.0 : 0.5,
                    child: StaticSceneWidget(model: boss.animatedScene),
                  );
            },
          ),
        ),
      ],
    );
  }
}
