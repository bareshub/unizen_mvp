import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/static_scene/static_scene.dart';
import '../../core/ui/frosted_glass_box.dart';
import '../../core/ui/frosted_glass_text_button.dart';
import '../../core/ui/vertical_text.dart';
import '../../static_scene/widgets/static_scene_widget.dart';
import '../view_models/add_exam_page_view_model.dart';

class AddExamPage extends StatelessWidget {
  final String? rVerticalText;

  const AddExamPage({super.key, this.rVerticalText});

  @override
  Widget build(BuildContext context) {
    final viewModel = AddExamPageViewModel();

    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'New Exam Boss',
                  stepGranularity: 4.0,
                  style: Theme.of(context).textTheme.headlineMedium,
                  minFontSize: 16.0,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                CarouselExamView(),
                SizedBox(height: 32.0),
                TextField(),
                SizedBox(height: 32.0),
                FrostedGlassTextButton(
                  text: 'Cancel',
                  action: () {},
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: 8.0),
                FrostedGlassTextButton(text: 'Add', action: () {}),
              ],
            ),
          ),
          if (rVerticalText != null)
            VerticalText(
              text: rVerticalText!,
              alignment: Alignment.centerRight,
            ),
        ],
      ),
    );
  }
}

class CarouselExamView extends StatefulWidget {
  const CarouselExamView({super.key});

  @override
  State<CarouselExamView> createState() => _CarouselExamViewState();
}

class _CarouselExamViewState extends State<CarouselExamView> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final carouselController = CarouselController(initialItem: _index);

    return Row(
      children: [
        IconButton(
          onPressed: () {
            _index = (_index - 1).clamp(0, 4);
            carouselController.animateToItem(_index);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: CarouselView.weighted(
              onTap: (index) {
                _index = index;
                carouselController.animateToItem(_index);
              },
              shape: RoundedRectangleBorder(),
              scrollDirection: Axis.horizontal,
              flexWeights: [4, 5, 4],
              enableSplash: false,
              itemSnapping: true,
              backgroundColor: Colors.transparent,
              controller: carouselController,
              children: List<Widget>.generate(5, (int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 64.0),
                      child: FrostedGlassBox(
                        borderRadius: 16.0,
                        child: Center(
                          child: Column(
                            children: [Spacer(), Text('$index'), Text('ECTS')],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 64.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth < 2
                                ? Text('Hello')
                                : StaticSceneWidget(
                                  model: StaticScene(
                                    modelAssetPath:
                                        'build/models/tvman_multiple_supreme.model',
                                    cameraDistance: 24,
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _index = (_index + 1).clamp(0, 4);
            carouselController.animateToItem(_index);
          },
          icon: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
