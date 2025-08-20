import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unizen/ui/roadmap_screen/view_models/roadmap_screen_view_model.dart';

import '../../../domain/models/boss/boss.dart';
import '../../../domain/models/exam/exam.dart';
import '../../../ui/core/ui/liquid_glass_icon_button.dart';
import '../view_models/add_exam_page_view_model.dart';
import 'boss_selection_carousel.dart';

class AddExamModal extends StatelessWidget {
  const AddExamModal({
    super.key,
    required this.viewModel,
    required this.timelineScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final RoadmapScreenViewModel timelineScreenViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AddExamModalHeader(
          viewModel: viewModel,
          timelineScreenViewModel: timelineScreenViewModel,
        ),
        BossSelectionCarousel(viewModel: viewModel),
        SizedBox(height: 16.0),
        _AddExamModalTextField(
          viewModel: viewModel,
          timelineScreenViewModel: timelineScreenViewModel,
        ),
      ],
    );
  }
}

class _AddExamModalHeader extends StatefulWidget {
  const _AddExamModalHeader({
    required this.viewModel,
    required this.timelineScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final RoadmapScreenViewModel timelineScreenViewModel;

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
    widget.timelineScreenViewModel.addExamCommand.execute(
      Exam(boss: boss, name: widget.viewModel.examName.value),
    );
  }
}

class _AddExamModalTextField extends StatefulWidget {
  const _AddExamModalTextField({
    required this.viewModel,
    required this.timelineScreenViewModel,
  });

  final AddExamPageViewModel viewModel;
  final RoadmapScreenViewModel timelineScreenViewModel;

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
      widget.timelineScreenViewModel.addExamCommand.execute(
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
