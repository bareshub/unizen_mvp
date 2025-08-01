import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unizen/domain/models/exam/exam_page.dart';

import '../../core/ui/unizen_logo.dart';
import '../view_models/exam_page_view_model.dart';
import '../view_models/home_screen_view_model.dart';
import 'add_exam_page_widget.dart';
import 'exam_page_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key, required this.viewModel});

  final HomeScreenViewModel viewModel;

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 1);
    widget.viewModel.initCommand.execute(_pageController);
    widget.viewModel.loadExamsCommand.executeWithFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _HomePageHeader(),
            _HomePageBody(widget: widget, pageController: _pageController),
            _PageIndicator(pageController: _pageController, widget: widget),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }
}

class _HomePageHeader extends StatelessWidget {
  const _HomePageHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: const UnizenLogo());
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    required this.widget,
    required PageController pageController,
  }) : _pageController = pageController;

  final HomeScreenWidget widget;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: widget.viewModel.sceneReady,
        builder: (_, sceneReady, _) {
          return sceneReady
              ? ValueListenableBuilder(
                valueListenable: widget.viewModel.pages,
                builder: (context, value, child) {
                  return PageView(
                    allowImplicitScrolling: true,
                    controller: _pageController,
                    children: [
                      AddExamPageWidget(viewModel: widget.viewModel),
                      ...widget.viewModel.pages.value.map(
                        (x) => ExamPageWidget(
                          key: ValueKey(x.exam.id),
                          viewModel: ExamPageViewModel(
                            model: ExamPage(
                              exam: x.exam,
                              lVerticalText: x.lVerticalText,
                              rVerticalText: x.rVerticalText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
              : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
        },
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required PageController pageController,
    required this.widget,
  }) : _pageController = pageController;

  final PageController _pageController;
  final HomeScreenWidget widget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.pages,
      builder: (context, value, child) {
        return SmoothPageIndicator(
          controller: _pageController,
          count: widget.viewModel.pages.value.length + 1,
          effect: ScrollingDotsEffect(
            activeDotColor: Theme.of(context).colorScheme.secondary,
            dotColor: Theme.of(context).colorScheme.primaryContainer,
            dotHeight: 8.0,
            dotWidth: 8.0,
          ),
        );
      },
    );
  }
}
