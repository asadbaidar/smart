part of 'extensions.dart';

extension SliverWidget on Widget {
  Widget get sliverFill => SliverFillRemaining(child: this);

  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
