import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:unizen/ui/core/ui/unizen_logo.dart';
import '../view_models/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomePageViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    widget.viewModel.init(_pageController);
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
                _HomePageHeader(),
                _HomePageBody(widget: widget, pageController: _pageController),
                _PageIndicator(pageController: _pageController, widget: widget),
              ],
            ),
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

  final HomePage widget;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
        animation: widget.viewModel,
        builder: (context, _) {
          return widget.viewModel.sceneReady
              ? PageView(
                allowImplicitScrolling: true,
                controller: _pageController,
                children: widget.viewModel.buildPages(),
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
  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: widget.viewModel.pageCount,
      effect: ScrollingDotsEffect(
        activeDotColor: Theme.of(context).colorScheme.secondary,
        dotColor: Theme.of(context).colorScheme.primaryContainer,
        dotHeight: 8.0,
        dotWidth: 8.0,
      ),
    );
  }
}
