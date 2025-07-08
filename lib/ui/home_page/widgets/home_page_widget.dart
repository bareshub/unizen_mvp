import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
import 'package:unizen/ui/animated_scene/view_models/rotation_view_model.dart';
import 'package:unizen/ui/core/ui/unizen_logo.dart';

import '../view_models/home_page_view_model.dart';
import '../widgets/add_exam_page.dart';
import '../widgets/exam_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomePageViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RotationViewModel> rotationViewModels = [];

  late final PageController _pageController;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    AnimatedScene.initialize().then((_) {
      rotationViewModels =
          widget.viewModel.exams.map((_) => RotationViewModel()).toList();
      setState(() {
        _sceneReady = true;
      });
    });

    _pageController = PageController(initialPage: 1);

    _pageController.addListener(() {
      final page = _pageController.page ?? 0.0;

      final intPart = page.floor();
      final decimalPart = page - intPart;

      if (decimalPart != 0 &&
          widget.viewModel.exams.elementAtOrNull(intPart) != null) {
        // setState(() {});
        var lIndex = intPart - 1;
        var rIndex = intPart;

        rotationViewModels
            .elementAt(lIndex)
            .rotateCommand
            .execute(decimalPart * pi / 3);

        rotationViewModels
            .elementAt(rIndex)
            .rotateCommand
            .execute(-(1 - decimalPart) * pi / 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity, child: const UnizenLogo()),
                Expanded(
                  child:
                      _sceneReady
                          ? PageView(
                            allowImplicitScrolling: true,
                            controller: _pageController,
                            children: [
                              AddExamPage(),
                              ...widget.viewModel.exams.asMap().entries.map((
                                entry,
                              ) {
                                final index = entry.key;
                                final exam = entry.value;

                                final lVerticalText = switch (index) {
                                  0 => 'NEW EXAM',
                                  _ =>
                                    widget.viewModel.exams
                                        .elementAt(index - 1)
                                        .name,
                                };

                                final rVerticalText =
                                    index == widget.viewModel.exams.length - 1
                                        ? ''
                                        : widget.viewModel.exams
                                            .elementAt(index + 1)
                                            .name;

                                // if (animatedSceneViewModels.length > index) {
                                //   debugPrint('updated $index');
                                //   animatedSceneViewModels[index] =
                                //       AnimatedSceneViewModel(
                                //         config: examNode.exam.sceneConfig,
                                //       );
                                // } else {
                                //   animatedSceneViewModels.add(
                                //     AnimatedSceneViewModel(
                                //       config: examNode.exam.sceneConfig,
                                //     ),
                                //   );
                                // }

                                return ExamPage(
                                  rotationViewModel: rotationViewModels[index],
                                  exam: exam,
                                  lVerticalText: lVerticalText,
                                  rVerticalText: rVerticalText,
                                );
                              }),
                            ],
                          )
                          : Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.viewModel.exams.length + 1,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                    dotColor: Theme.of(context).colorScheme.primaryContainer,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var vm in rotationViewModels) {
      vm.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }
}
