import 'package:ProyectoAnalisis2/features/user/presentation/bloc/sharedata/share_data_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/bloc/userbloc/user_bloc.dart';
import 'package:ProyectoAnalisis2/features/user/data/models/usermodel.dart';
import 'package:ProyectoAnalisis2/features/user/presentation/pages/user_page_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutHomePage extends StatelessWidget {
  const LayoutHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          return Container(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<UserBloc>(context).add(GetUserForRandom());
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                ).copyWith(top: MediaQuery.of(context).size.height * 0.08),
                itemCount: state.user.data.length,
                itemBuilder: (_, i) {
                  return CustomCardUserInfo(
                    userInfo: state.user.data[i],
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class CustomCardUserInfo extends StatelessWidget {
  const CustomCardUserInfo({
    Key key,
    @required this.userInfo,
  })  : assert(
          userInfo != null,
        ),
        super(key: key);
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.09,
      ).copyWith(
        bottom: screenHeight * 0.08,
      ),
      height: screenHeight * 0.3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.03,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Hero(
                  tag: userInfo.id,
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => UserPageDetail(),
                          ),
                        );
                        BlocProvider.of<ShareDataBloc>(context)
                            .add(ShareDataBetweenPage(userInfo: userInfo));
                      },
                      child: CachedNetworkImage(
                        width: ScreenUtil().setWidth(300),
                        height: ScreenUtil().setHeight(280.0),
                        fit: BoxFit.cover,
                        imageUrl: userInfo.avatar,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.15),
            alignment: Alignment.center,
            child: Text(
              '${userInfo.firstName} ${userInfo.lastName}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(
                  60.0,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 5),
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5.0,
          )
        ],
      ),
    );
  }
}
