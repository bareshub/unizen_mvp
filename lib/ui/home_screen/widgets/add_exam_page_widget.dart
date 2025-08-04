import 'package:flutter/material.dart';

import '../../../ui/core/ui/liquid_glass_icon_button.dart';
import '../view_models/add_exam_page_view_model.dart';
import '../view_models/home_screen_view_model.dart';
import 'add_exam_modal.dart';

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
