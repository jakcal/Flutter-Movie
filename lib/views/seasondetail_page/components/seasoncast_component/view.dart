import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonCastState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildCreditsShimmerCell() {
    return SizedBox(
      width: Adapt.px(220),
      height: Adapt.px(450),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              width: Adapt.px(220),
              height: Adapt.px(300),
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(
                  0, Adapt.px(5), Adapt.px(70), Adapt.px(20)),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCastCell(CastData d) {
    return GestureDetector(
      key: ValueKey(d.id),
      onTap: () => dispatch(SeasonCastActionCreator.onCastCellTapped(
          d.id, d.profilePath, d.name)),
      child: Container(
        padding: EdgeInsets.only(left: Adapt.px(30)),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                  tag: 'people' + d.id.toString(),
                  child: Container(
                    width: Adapt.px(220),
                    height: Adapt.px(300),
                    decoration: BoxDecoration(
                        color: _theme.primaryColorLight,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(ImageUrl.getUrl(
                                d.profilePath, ImageSize.w200)))),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(
                    Adapt.px(8), Adapt.px(10), Adapt.px(8), 0),
                width: Adapt.px(220),
                child: Text(
                  d.name,
                  style: TextStyle(
                      fontSize: Adapt.px(26), fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(Adapt.px(8), 0, Adapt.px(8), 0),
                width: Adapt.px(220),
                child: Text(d.character,
                    maxLines: 2,
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(26))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCastBody() {
    if (state.castData != null)
      return Container(
        height: Adapt.px(450),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: state.castData.map(_buildCastCell).toList(),
        ),
      );
    else
      return Container(
        height: Adapt.px(450),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: Adapt.px(30),
            ),
            _buildCreditsShimmerCell(),
            SizedBox(
              width: Adapt.px(30),
            ),
            _buildCreditsShimmerCell(),
            SizedBox(
              width: Adapt.px(30),
            ),
            _buildCreditsShimmerCell()
          ],
        ),
      );
  }

  return Container(
    key: ValueKey(state.castData),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: I18n.of(viewService.context).seasonCast,
                style: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ' ${state.castData != null ? state.castData.length.toString() : ''}',
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
          ])),
        ),
        _buildCastBody(),
      ],
    ),
  );
}
