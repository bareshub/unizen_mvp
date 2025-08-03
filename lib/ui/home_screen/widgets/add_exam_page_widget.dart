import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../ui/core/ui/liquid_glass_icon_button.dart';
import '../../core/ui/frosted_glass_box.dart';
import '../../static_scene/widgets/static_scene_widget.dart';
import '../view_models/add_exam_page_view_model.dart';
import '../view_models/home_screen_view_model.dart';

class AddExamPageWidget extends StatelessWidget {
  const AddExamPageWidget({
    super.key,
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LiquidGlassIconButton(
        icon: Icons.add_rounded,
        size: 80.0,
        onPressed: () => _onAddExamPressed(context),
      ),
    );
  }

  void _onAddExamPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.primary,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 120.0,
          child: AddExamModal(
            viewModel: viewModel,
            homeScreenViewModel: homeScreenViewModel,
          ),
        );
      },
    );
  }
}

class AddExamModal extends StatelessWidget {
  const AddExamModal({
    super.key,
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AddExamModalHeader(
          viewModel: viewModel,
          homeScreenViewModel: homeScreenViewModel,
        ),
        _AddExamModalBossPicker(
          viewModel: viewModel,
          homeScreenViewModel: homeScreenViewModel,
        ),
        SizedBox(height: 16.0),
        _AddExamModalTextField(
          viewModel: viewModel,
          homeScreenViewModel: homeScreenViewModel,
        ),
      ],
    );
  }
}

class _AddExamModalHeader extends StatefulWidget {
  const _AddExamModalHeader({
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<_AddExamModalHeader> createState() => _AddExamModalHeaderState();
}

class _AddExamModalHeaderState extends State<_AddExamModalHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: [
          LiquidGlassIconButton(
            onPressed: () => _onClosePressed(context),
            icon: Icons.close_rounded,
            size: 40.0,
          ),
          Spacer(),
          Text(
            'Add Exam Boss',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Spacer(),
          ValueListenableBuilder(
            valueListenable: widget.viewModel.examName,
            builder: (context, _, _) {
              return LiquidGlassIconButton(
                onPressed:
                    widget.viewModel.isExamNameValid
                        ? () => _onConfirmPressed(
                          context,
                          boss: widget.viewModel.bosses.value.elementAt(
                            widget.viewModel.selectedBossIndex.value,
                          ),
                        )
                        : null,
                icon: Icons.check_rounded,
                size: 40.0,
              );
            },
          ),
        ],
      ),
    );
  }

  void _onClosePressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onConfirmPressed(BuildContext context, {required Boss boss}) {
    Navigator.of(context).pop();
    widget.homeScreenViewModel.addExamCommand.execute(
      Exam(boss: boss, name: widget.viewModel.examName.value),
    );
  }
}

class _AddExamModalBossPicker extends StatefulWidget {
  const _AddExamModalBossPicker({
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<_AddExamModalBossPicker> createState() =>
      _AddExamModalBossPickerState();
}

class _AddExamModalBossPickerState extends State<_AddExamModalBossPicker> {
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
        builder: (context, index, _) {
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
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 64.0),
                                    child: FrostedGlassBox(
                                      alpha: entry.key == index ? 96 : 56,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              entry.value.ects % 1 == 0
                                                  ? '${entry.value.ects.toInt()}'
                                                  : '${entry.value.ects}',
                                              style:
                                                  entry.key == index
                                                      ? Theme.of(
                                                        context,
                                                      ).textTheme.headlineMedium
                                                      : Theme.of(
                                                        context,
                                                      ).textTheme.labelMedium,
                                            ),
                                            Text(
                                              'ECTS',
                                              style:
                                                  entry.key == index
                                                      ? Theme.of(
                                                        context,
                                                      ).textTheme.labelMedium
                                                      : Theme.of(
                                                        context,
                                                      ).textTheme.labelSmall,
                                            ),
                                            SizedBox(height: 16.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: double.infinity,
                                    height: 250,
                                    padding: EdgeInsets.only(
                                      bottom: 72.0,
                                      top: entry.key == index ? 0 : 64,
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return constraints.maxWidth < 2
                                            ? SizedBox()
                                            : Opacity(
                                              opacity:
                                                  entry.key == index ? 1 : 0.5,
                                              child: StaticSceneWidget(
                                                model:
                                                    entry.value.animatedScene,
                                              ),
                                            );
                                      },
                                    ),
                                  ),
                                ],
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

class _AddExamModalTextField extends StatefulWidget {
  const _AddExamModalTextField({
    required this.viewModel,
    required this.homeScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<_AddExamModalTextField> createState() => _AddExamModalTextFieldState();
}

class _AddExamModalTextFieldState extends State<_AddExamModalTextField> {
  late final TextEditingController _textEditingController;
  late final FocusNode _textFieldFocusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textFieldFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            _textFieldFocusNode.requestFocus();
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 52.0),
      child: TextField(
        controller: _textEditingController,
        focusNode: _textFieldFocusNode,
        onChanged: widget.viewModel.setExamNameCommand.execute,
        onSubmitted:
            (_) => _onSubmitted(
              context,
              boss: widget.viewModel.bosses.value.elementAt(
                widget.viewModel.selectedBossIndex.value,
              ),
            ),
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            return newValue.copyWith(
              text: newValue.text.toUpperCase(),
              selection: newValue.selection,
            );
          }),
        ],
        canRequestFocus: true,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        cursorHeight: 24,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          filled: true,
          fillColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withAlpha(128),
          hintText: 'Exam Name',
          hintStyle: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          // visualDensity: VisualDensity.compact,
          // isDense: true,
        ),
        keyboardAppearance: Brightness.dark,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
          height: 1,
        ),
        textCapitalization: TextCapitalization.characters,
      ),
    );
  }

  void _onSubmitted(BuildContext context, {required Boss boss}) {
    if (widget.viewModel.isExamNameValid) {
      Navigator.of(context).pop();
      widget.homeScreenViewModel.addExamCommand.execute(
        Exam(boss: boss, name: widget.viewModel.examName.value),
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }
}
