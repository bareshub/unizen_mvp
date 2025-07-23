import 'package:flutter/material.dart';
import 'package:unizen/ui/core/ui/frosted_glass_text_button.dart';
import 'package:unizen/ui/home_page/view_models/add_exam_page_view_model.dart';

class AddExamPage extends StatelessWidget {
  final String? rVerticalText;

  const AddExamPage({super.key, this.rVerticalText});

  @override
  Widget build(BuildContext context) {
    final viewModel = AddExamPageViewModel();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('New Exam', style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CarouselView.weighted(
              scrollDirection: Axis.horizontal,
              flexWeights: [2, 3, 2],
              itemSnapping: true,

              children: List<Widget>.generate(10, (int index) {
                return Container(
                  height: 300,
                  color: Colors.blueGrey,
                  child: Text('Item $index'),
                );
              }),
            ),
          ),
          SizedBox(height: 32.0),
          TextField(),
          SizedBox(height: 32.0),
          FrostedGlassTextButton(
            text: 'Cancel',
            action: () {},
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 32.0),
          FrostedGlassTextButton(text: 'Add', action: () {}),
        ],
      ),
    );
  }
}
