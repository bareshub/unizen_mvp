import 'package:flutter/material.dart' hide Animation;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unizen/domain/models/animated_scene/animated_scene.dart';
import 'package:unizen/domain/models/boss/boss.dart';
import 'package:unizen/domain/models/health_bar/health_bar.dart';
import 'package:unizen/ui/core/ui/liquid_glass_box.dart';
import 'package:unizen/ui/core/ui/liquid_glass_icon_button.dart';
import 'package:unizen/ui/core/ui/roadmap_paint.dart';

import '../../../domain/models/exam/exam.dart';
import '../../animated_scene/widgets/animated_scene_widget.dart';
import '../../health_bar/view_models/health_bar_view_model.dart';
import '../../health_bar/widgets/health_bar_widget.dart';
import '../../home_screen/view_models/add_exam_page_view_model.dart';
import '../../home_screen/widgets/add_exam_modal.dart';
import '../view_models/roadmap_screen_view_model.dart';

class RoadmapScreenWidget extends StatefulWidget {
  const RoadmapScreenWidget({super.key, required this.viewModel});

  static const horizontalMargin = 48.0;
  static const bossHeight = 120.0;
  static const spaceAboveBoss = 12.0;
  static const spaceBetweenBossAndHealthBar = 8.0;
  static const spaceBelowHealthBar = 24.0;
  static const HealthBarSize healthBarSize = HealthBarSize.medium;
  static const plusButtonSize = 72.0;

  final RoadmapScreenViewModel viewModel;

  @override
  State<RoadmapScreenWidget> createState() => _RoadmapScreenWidgetState();
}

class _RoadmapScreenWidgetState extends State<RoadmapScreenWidget>
    with AutomaticKeepAliveClientMixin {
  late final AddExamPageViewModel addExamPageViewModel;

  double get bossHeight =>
      RoadmapScreenWidget.bossHeight +
      RoadmapScreenWidget.spaceAboveBoss +
      RoadmapScreenWidget.spaceBetweenBossAndHealthBar +
      RoadmapScreenWidget.healthBarSize.height +
      RoadmapScreenWidget.spaceBelowHealthBar;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    addExamPageViewModel = AddExamPageViewModel(bossRepository: context.read());
    _loadData();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          (widget.viewModel.state.value == RoadmapScreenState.initial ||
              widget.viewModel.exams.value.isEmpty)) {
        widget.viewModel.loadCommand.execute();
      }
    });
  }

  @override
  void deactivate() {
    // Save state before widget is removed from tree
    super.deactivate();
  }

  @override
  void dispose() {
    addExamPageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ValueListenableBuilder(
                  valueListenable: widget.viewModel.state,
                  builder: (context, state, child) {
                    // TODO implement return values based on state
                    return switch (state) {
                      RoadmapScreenState.initial => Center(
                        child: CircularProgressIndicator(),
                      ),
                      RoadmapScreenState.loading => Center(
                        child: CircularProgressIndicator(),
                      ),
                      RoadmapScreenState.error => Center(
                        child: CircularProgressIndicator(),
                      ),
                      _ => child!,
                    };
                  },
                  child: ValueListenableBuilder(
                    valueListenable: widget.viewModel.exams,
                    builder: (context, exams, _) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              _buildBossEmptyPlaceholder(),
                              _buildBossEmptyPlaceholder(
                                button: Row(
                                  children: [
                                    if (exams.length.isEven) Spacer(flex: 3),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: _buildAddExamButton(),
                                      ),
                                    ),
                                    if (exams.length.isOdd) Spacer(flex: 3),
                                  ],
                                ),
                              ),
                              ...exams.asMap().entries.map<Widget>((entry) {
                                final left = entry.key.isOdd;

                                return _buildBoss(entry.value, left);
                              }),
                              SizedBox(height: 32.0),
                            ],
                          ),
                          Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: RoadmapProgressWidget(
                              bossesCount: exams.length,
                              bossHeight: bossHeight,
                              progress: 0.1,
                            ),
                          ),
                          Positioned(
                            top: 1048 - 120,
                            child: SizedBox(
                              height: 120,
                              width: 50,
                              child: AnimatedSceneWidget(
                                exam: Exam(
                                  boss: Boss(
                                    animatedScene: AnimatedScene(
                                      modelAssetPath:
                                          'build/models/minecraft_sprunki_oren_after_blender.model',
                                      defaultAnimation: Animation.walk,
                                      cameraDistance: 10,
                                      showBack: true,
                                    ),
                                    ects: 0,
                                  ),
                                  name: '',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: bossHeight,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 80.0),
                child: LiquidGlassBox(
                  ambientStrength: 0.5,
                  chromaticAberration: 10,
                  lightness: 0.95,
                  refractiveIndex: 1.51,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // Icon(
                            //   Icons.school_outlined,
                            //   color: Colors.blue.withAlpha(160),
                            //   size: 20,
                            // ),
                            // SizedBox(width: 8.0),
                            Text(
                              'University: ',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'DTU',
                              style: Theme.of(context).textTheme.headlineMedium,
                              // ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.flag_outlined,
                            //   color: Colors.red.withAlpha(160),
                            //   size: 20,
                            // ),
                            // SizedBox(width: 8.0),
                            Text(
                              'Exams Passed: ',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '0 ',
                              style: Theme.of(context).textTheme.headlineMedium,
                              // ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              '/ 4',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.leaderboard_outlined,
                            //   color: Colors.green.withAlpha(160),
                            //   size: 20,
                            // ),
                            // SizedBox(width: 8.0),
                            Text(
                              'GPA: ',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '10.5 ',
                              style: Theme.of(context).textTheme.headlineMedium,
                              // ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              '/ 12',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ), // TODO replace with info box
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddExamButton() => LiquidGlassIconButton(
    icon: Icons.add_rounded,
    size: RoadmapScreenWidget.plusButtonSize,
    onPressed:
        () => showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.primary,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 120.0,
              child: AddExamModal(
                viewModel: addExamPageViewModel,
                timelineScreenViewModel: widget.viewModel,
              ),
            );
          },
        ), // TODO
  );

  Widget _buildBoss(Exam exam, bool left) {
    final bossInfo = Expanded(
      flex: 3,
      child: Container(
        height: bossHeight,
        margin: EdgeInsets.only(
          left: left ? 32.0 : 8.0,
          right: left ? 8.0 : 32.0,
        ),
        alignment:
            left ? AlignmentGeometry.centerRight : AlignmentGeometry.centerLeft,
        child: Text(
          exam.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: left ? TextAlign.end : TextAlign.start,
          style: GoogleFonts.sixCaps(
            color: Colors.white.withAlpha((0.75 * 255).toInt()),
            fontWeight: FontWeight.w500,
            height: 1.0,
            fontSize: 36.0,
          ),
        ),
      ),
    );

    return Row(
      key: ValueKey(exam.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (left) bossInfo,
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: RoadmapScreenWidget.spaceAboveBoss),
              InkWell(
                onTap: () => context.push('/exam', extra: exam),
                splashColor: Colors.white38,
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(40.0),
                child: _AnimatedSceneSection(
                  exam: exam,
                  height: RoadmapScreenWidget.bossHeight,
                ),
              ),
              const SizedBox(
                height: RoadmapScreenWidget.spaceBetweenBossAndHealthBar,
              ),
              _HealthBarSection(
                exam: exam,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              const SizedBox(height: RoadmapScreenWidget.spaceBelowHealthBar),
            ],
          ),
        ),
        if (!left) bossInfo,
      ],
    );
  }

  Widget _buildBossEmptyPlaceholder({Widget? button}) {
    return SizedBox(height: bossHeight, child: button);
  }
}

// TODO extract
class _AnimatedSceneSection extends StatelessWidget {
  const _AnimatedSceneSection({
    required this.exam,
    required this.height,
    this.margin,
  });

  final Exam exam;
  final double height;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: AnimatedSceneWidget(exam: exam),
    );
  }
}

// TODO extract
class _HealthBarSection extends StatelessWidget {
  const _HealthBarSection({required this.exam, this.margin});

  final Exam exam;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return HealthBarWidget(
      viewModel: HealthBarViewModel(
        config: HealthBar(size: HealthBarSize.medium),
        maxHealth: exam.maxHealth,
        health: exam.health,
      ),
      margin: margin,
    );
  }
}
