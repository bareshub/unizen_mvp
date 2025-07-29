import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/ui/unizen_logo.dart';
import '../view_models/home_screen_view_model.dart';

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

    widget.viewModel.loadCommand.execute();
    widget.viewModel.initCommand.execute(_pageController);
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
                valueListenable: widget.viewModel.pageCount,
                builder: (context, value, child) {
                  return PageView(
                    allowImplicitScrolling: true,
                    controller: _pageController,
                    children: widget.viewModel.pages,
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
      valueListenable: widget.viewModel.pageCount,
      builder: (context, value, child) {
        return SmoothPageIndicator(
          controller: _pageController,
          count: widget.viewModel.pageCount.value,
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
