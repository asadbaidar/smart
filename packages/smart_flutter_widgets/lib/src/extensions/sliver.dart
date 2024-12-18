import 'package:flutter/material.dart';

extension SliverWidget on Widget {
  Widget get sliverFill => SliverFillRemaining(child: this);

  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
