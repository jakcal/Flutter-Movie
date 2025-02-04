import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    OverViewState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildOverWatch() {
    final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
    Widget _overWatch = state.overView == null
        ? Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.px(300),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                )
              ],
            ),
          )
        : Text(state.overView ?? '');
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Adapt.px(30),
            ),
            Text(
              I18n.of(viewService.context).overView,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
            ),
            SizedBox(
              height: Adapt.px(20),
            ),
            _overWatch,
          ],
        ),
      ),
    );
  }

  return _buildOverWatch();
}
