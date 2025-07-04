import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:unizen/ui/animated_scene/animated_scene.dart';
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
  List<AnimatedSceneViewModel> animatedSceneViewModels = [];

  late final PageController _pageController;
  bool _sceneReady = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 1);

    _pageController.addListener(() {
      final page = _pageController.page ?? 0.0;

      final intPart = page.floor();

      final decimalPart = page - intPart;

      if (decimalPart != 0 &&
          widget.viewModel.examNodes.elementAtOrNull(intPart + 1) != null) {
        var lIndex = intPart - 1;
        var rIndex = intPart;

        animatedSceneViewModels
            .elementAt(lIndex)
            .rotateCommand
            .execute(decimalPart * pi / 3);

        animatedSceneViewModels
            .elementAt(rIndex)
            .rotateCommand
            .execute(-(1 - decimalPart) * pi / 3);
      }
    });

    AnimatedScene.initialize().then((_) {
      setState(() {
        _sceneReady = true;
      });
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
                              ...widget.viewModel.examNodes.map((examNode) {
                                var lVerticalText =
                                    examNode.previous == null
                                        ? 'NEW EXAM'
                                        : examNode.exam.name;

                                var rVerticalText =
                                    examNode.next == null
                                        ? ''
                                        : examNode.exam.name;

                                var animatedSceneViewModel =
                                    AnimatedSceneViewModel(
                                      config: examNode.exam.sceneConfig,
                                    );

                                animatedSceneViewModels.add(
                                  animatedSceneViewModel,
                                );

                                return ExamPage(
                                  animatedSceneViewModel:
                                      animatedSceneViewModel,
                                  exam: examNode.exam,
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
                  count: widget.viewModel.examNodes.length + 1,
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
    _pageController.dispose();
    super.dispose();
  }
}
