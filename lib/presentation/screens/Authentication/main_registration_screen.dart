import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resty_app/core/app_export.dart';
import 'package:resty_app/presentation/widgets/button_state.dart';
import 'package:resty_app/presentation/widgets/custom_outlined_button.dart';

class MainRegistrationScreen extends StatelessWidget {
  const MainRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 24.v),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgRoommateroots1,
                      height: 250.v,
                      width: 282.h),
                  SizedBox(height: 28.v),
                  _buildTenantRegistrationButton(context),
                  SizedBox(height: 8.v),
                  _buildOwnerRegistrationButton(context),
                  SizedBox(height: 8.v),
                  _buildCancelButton(context)
                ]))));
  }

  Widget _buildTenantRegistrationButton(BuildContext context) {
    return Consumer<ButtonState>(builder: (context, ButtonState, _) {
      return CustomOutlinedButton(
          text: "Inquilino",
          margin: EdgeInsets.symmetric(horizontal: 34.h),
          onPressed: () {
            ButtonState.setResetPasswordPressed("Tenant");
            onTapTenant(context);
          });
    });
  }

  Widget _buildOwnerRegistrationButton(BuildContext context) {
    return Consumer<ButtonState>(builder: (context, ButtonState, _) {
      return CustomOutlinedButton(
          text: "Propietario",
          margin: EdgeInsets.symmetric(horizontal: 34.h),
          onPressed: () {
            ButtonState.setResetPasswordPressed("Owner");
            onTapOwner(context);
          });
    });
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomOutlinedButton(
        text: "Cancelar",
        margin: EdgeInsets.only(left: 34.h, right: 33.h),
        onPressed: () {
          onTapCancel(context);
        });
  }

  onTapTenant(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tenantRegistrationScreen);
  }

  onTapOwner(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.ownerRegistrationScreen);
  }

  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}