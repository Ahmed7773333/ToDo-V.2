import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/cache/hive_helper/helper.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/core/utils/app_animations.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/features/Home%20Layout/presentation/bloc/home_layout_bloc.dart';
import 'package:todo/features/Home%20Layout/presentation/pages/history.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/profile_row.dart';
import 'package:todo/features/Settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/utils/componetns.dart';

// ignore: must_be_immutable
class ProfileTab extends StatefulWidget {
  ProfileTab(this.user, this.bloc, {super.key});
  final UserDb user;
  final HomeLayoutBloc bloc;
  bool right = false;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: widget.user.name);
    TextEditingController password = TextEditingController();
    TextEditingController confermPassword = TextEditingController();
    final strings = AppLocalizations.of(context)!;
    final colorss = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.profile,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 85.w,
                  height: 85.h,
                  decoration: ShapeDecoration(
                    shape: const OvalBorder(),
                    image: DecorationImage(
                      image: MemoryImage(widget.user.image),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                  child: Text(widget.user.name,
                      style: Theme.of(context).textTheme.titleLarge)),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Components.fillButton(context,
                      color: colorss.onPrimary,
                      text:
                          '${pendedTaskHelper.getAll().length} ${strings.pended}',
                      onPressed: () async {
                    await Navigator.push(
                        context, TopRouting(const History(false)));
                    setState(() {});
                  }),
                  Components.fillButton(context,
                      color: colorss.onPrimary,
                      text:
                          '${completedTaskHelper.getAll().length} ${strings.done}',
                      onPressed: () async {
                    await Navigator.push(
                        context, TopRouting(const History(true)));
                    setState(() {});
                  }),
                ],
              ),
              SizedBox(height: 20.h),
              Text(strings.settings,
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16.h),
              profileRow(
                  Icon(Icons.settings_outlined, size: 24.r), strings.settings,
                  () {
                Navigator.push(context, RightRouting(const Settings()));
              }, context),
              SizedBox(height: 28.h),
              Text(strings.account,
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16.h),
              profileRow(
                  Image.asset(AppImages.profile), strings.changeaccountname,
                  () {
                showEditName(name, widget.bloc);
              }, context),
              SizedBox(height: 32.h),
              profileRow(
                  Image.asset(AppImages.key), strings.changeaccountpassword,
                  () {
                showEditPassword(password, confermPassword, widget.bloc);
              }, context),
              SizedBox(height: 32.h),
              profileRow(
                  Image.asset(AppImages.camera), strings.changeaccountimage,
                  () {
                showImagePickerBottomSheet(context);
              }, context),
              SizedBox(height: 28.h),
              Text(strings.uptodo,
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16.h),
              profileRow(Image.asset(AppImages.menu), strings.aboutus, () {
                debugPrint('${widget.user.name}\n${widget.user.password}');
              }, context),
              SizedBox(height: 32.h),
              profileRow(Image.asset(AppImages.faq), strings.faq, () {
                debugPrint('${widget.user.name}\n${widget.user.password}');
              }, context),
              SizedBox(height: 32.h),
              profileRow(Image.asset(AppImages.flash), strings.helpfeedback,
                  () {
                debugPrint('${widget.user.name}\n${widget.user.password}');
              }, context),
              SizedBox(height: 32.h),
              profileRow(Image.asset(AppImages.like), strings.support, () {
                debugPrint('${widget.user.name}\n${widget.user.password}');
              }, context),
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final strings = AppLocalizations.of(context)!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(strings.pickfromgallery),
              onTap: () async {
                Navigator.pop(context);
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  Uint8List imageBytes = await pickedFile.readAsBytes();
                  // Use the imageBytes as needed
                  widget.user.image = imageBytes;
                  widget.bloc.add(UpdateUserEvent(user: widget.user));
                  debugPrint("Image Bytes Length: ${imageBytes.length}");
                } else {
                  debugPrint("No image picked.");
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(strings.taskaphoto),
              onTap: () async {
                Navigator.pop(context);
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  Uint8List imageBytes = await pickedFile.readAsBytes();
                  // Use the imageBytes as needed
                  widget.user.image = imageBytes;
                  widget.bloc.add(UpdateUserEvent(user: widget.user));
                  debugPrint("Image Bytes Length: ${imageBytes.length}");
                } else {
                  debugPrint("No image captured.");
                }
              },
            ),
          ],
        );
      },
    );
  }

  showEditName(
    TextEditingController name,
    HomeLayoutBloc bloc,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          final strings = AppLocalizations.of(context)!;
          final colorss = Theme.of(context).colorScheme;

          return AlertDialog(
            backgroundColor: colorss.onPrimary,
            surfaceTintColor: colorss.onPrimary,
            content: Components.customTextField(context,
                hint: strings.username, controller: name, onSubmit: () {
              widget.user.name = name.text;
              bloc.add(UpdateUserEvent(user: widget.user));
              name.clear();
              Navigator.pop(context);
            }),
          );
        });
  }

  showEditPassword(
    TextEditingController pass,
    TextEditingController cPass,
    HomeLayoutBloc bloc,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          final strings = AppLocalizations.of(context)!;
          final colorss = Theme.of(context).colorScheme;

          return AlertDialog(
            backgroundColor: colorss.onPrimary,
            surfaceTintColor: colorss.onPrimary,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Components.customTextField(context,
                    hint: strings.confirmpassword,
                    controller: cPass, onChange: () {
                  widget.right = cPass.text == widget.user.password;
                }),
                Components.customTextField(context,
                    hint: strings.password, controller: pass, onSubmit: () {
                  if (widget.right) {
                    widget.user.password = pass.text;
                    bloc.add(UpdateUserEvent(user: widget.user));
                    pass.clear();
                    cPass.clear();
                    Navigator.pop(context);
                  }
                }),
              ],
            ),
          );
        });
  }
}
