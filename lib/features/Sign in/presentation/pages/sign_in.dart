import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/core/utils/app_animations.dart';

import 'package:todo/core/utils/componetns.dart';
import 'package:todo/features/Home%20Layout/presentation/pages/home_layout.dart';
import 'package:todo/features/Sign%20in/presentation/bloc/sign_in_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (BuildContext context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = SignInBloc.get(context);
    final colorss = Theme.of(context).colorScheme;

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showImagePickerBottomSheet(context, bloc);
                    },
                    child: bloc.image.isEmpty
                        ? Container(
                            width: 85.w,
                            height: 85.h,
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(),
                            ),
                            child: Center(
                              child: Icon(Icons.add,
                                  color: colorss.secondary, size: 40.r),
                            ),
                          )
                        : Container(
                            width: 85.w,
                            height: 85.h,
                            decoration: ShapeDecoration(
                              shape: const OvalBorder(),
                              image: DecorationImage(
                                image: MemoryImage(bloc.image),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                  ),
                  Components.customTextField(context,
                      hint: strings.username,
                      controller: nameController, onChange: () {
                    bloc.add(ChooseName(name: nameController.text));
                  }),
                  Components.customTextField(
                    context,
                    hint: strings.password,
                    controller: passwordController,
                    isPassword: true,
                    isShow: bloc.isShow,
                    onChange: () {
                      bloc.add(
                          ChoosePassword(password: passwordController.text));
                    },
                    onPressed: () {
                      bloc.add(ChangeShow(isShow: !bloc.isShow));
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        FirstInEvent(
                          user: UserDb(
                            name: bloc.name,
                            image: bloc.image,
                            password: bloc.password,
                            isDark: true,
                            isEnglish: 'en',
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                          context, RightRouting(const HomeLayout()));
                    },
                    child: Center(
                      child: Text('Log in',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showImagePickerBottomSheet(BuildContext context, SignInBloc bloc) {
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
                  bloc.add(ChoosePhoto(photo: imageBytes));
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
                  bloc.add(ChoosePhoto(photo: imageBytes));
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
}
