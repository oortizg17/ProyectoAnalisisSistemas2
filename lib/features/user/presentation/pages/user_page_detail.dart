import 'package:ProyectoAnalisis2/core/utils/handle_local_info_user_detail.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/bloc/sharedata/share_data_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPageDetail extends StatelessWidget with HandleLocalInfoUserDetail {
  UserPageDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<ShareDataBloc, ShareDataState>(
        builder: (context, state) {
          if (state is ShareDataLoaded) {
            return Stack(
              children: [
                Hero(
                  tag: state.userInfo.id,
                  child: Container(
                    height: screenHeight * 0.4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: state.userInfo.avatar,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(200.0),
                    width: ScreenUtil().setWidth(800.0),
                    margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(400.0),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Center(
                        child: Text(
                          state.userInfo.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(50.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10),
                            blurRadius: 10.0,
                            spreadRadius: 3.0,
                          ),
                        ]),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(900.0),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(80.0),
                      ).copyWith(
                        top: ScreenUtil().setHeight(80.0),
                        bottom: ScreenUtil().setHeight(300.0),
                      ),
                      child: Text(
                        detail[state.userInfo.id],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(60.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Header(screenHeight: screenHeight),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: screenHeight * 0.08,
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0))
          .copyWith(top: ScreenUtil().setHeight(45.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setSp(100.0),
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<ShareDataBloc>(context).add(ResetState());
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
