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
    /* TODO WIP

    _pageController.addListener(() {
      final position = _pageController.page ?? 0.0;

      if (position > 2.3) {
        debugPrint(_pageController.toString());
      }
      final currentExamIntex = _pageController.page ?? 1 - 1;

      widget.viewModel.exams.elementAt(currentExamIntex.toInt());

      debugPrint('_pageController.page ${position.toString()}');
    });
    */

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
                              ...widget.viewModel.exams.map((exam) {
                                var indexOfExam = widget.viewModel.exams
                                    .indexOf(exam);

                                var animatedSceneViewModel =
                                    AnimatedSceneViewModel(
                                      config: SceneConfig(
                                        modelAssetPath: exam.modelAssetPath,
                                        environmentIntensity:
                                            exam.environmentIntensity,
                                        cameraDistance: exam.cameraDistance,
                                      ),
                                    );

                                var lVerticalText =
                                    indexOfExam == 0
                                        ? 'NEW EXAM'
                                        : widget.viewModel.exams
                                            .elementAt(indexOfExam - 1)
                                            .name;
                                var rVerticalText =
                                    indexOfExam + 1 >=
                                            widget.viewModel.exams.length
                                        ? ''
                                        : widget.viewModel.exams
                                            .elementAt(indexOfExam + 1)
                                            .name
                                            .toUpperCase();

                                return ExamPage(
                                  animatedSceneViewModel:
                                      animatedSceneViewModel,
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
    _pageController.dispose();
    super.dispose();
  }
}
