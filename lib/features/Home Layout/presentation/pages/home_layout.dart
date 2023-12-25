import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/task_db.dart';
import 'package:todo/core/cache/user_db.dart';
import 'package:todo/core/utils/app_images.dart';
import 'package:todo/features/Home%20Layout/data/datasources/local_ds_impl.dart';
import 'package:todo/features/Home%20Layout/data/repositories/home_repo_impl.dart';
import 'package:todo/features/Home%20Layout/domain/usecases/add_category.dart';
import 'package:todo/features/Home%20Layout/domain/usecases/add_task.dart';
import 'package:todo/features/Home%20Layout/presentation/pages/tabs/calender.dart';
import 'package:todo/features/Home%20Layout/presentation/pages/tabs/home.dart';
import 'package:todo/features/Home%20Layout/presentation/pages/tabs/profile.dart';
import 'package:todo/features/Home%20Layout/presentation/widgets/show_add_task.dart';
import 'package:uuid/uuid.dart';

import '../bloc/home_layout_bloc.dart';
import 'tabs/progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  // int _currentIndex = 0;
  // late PageController _pageController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => HomeLayoutBloc(
        AddCateoryUseCase(HomeRepoImpl(LocalDsImpl())),
        AddTaskUseCase(HomeRepoImpl(LocalDsImpl())),
      )
        ..add(GetAllTasksEvent())
        ..add(GetAllTasksAtDay(time: DateTime.now()))
        ..add(GetAllCategoriesEvent())
        ..add(GetUserEvent()),
      child: BlocConsumer<HomeLayoutBloc, HomeLayoutState>(
        listener: (context, state) {
          if (state.status == ScreenStatus.addTaskState) {
            showAddTask(titleController, descriptionController, context, () {
              HomeLayoutBloc.get(context).add(
                AddTaskEvent(
                  task: TaskDb(
                    title: titleController.text,
                    description: descriptionController.text,
                    done: HomeLayoutBloc.get(context).done,
                    priority: HomeLayoutBloc.get(context).priority,
                    categoryColor: HomeLayoutBloc.get(context).categoryColor,
                    categoryIcon: HomeLayoutBloc.get(context).categoryIcon,
                    categoryName: HomeLayoutBloc.get(context).categoryName,
                    time: HomeLayoutBloc.get(context).time,
                    repeat: false,
                    id: const Uuid().v4(),
                  ),
                ),
              );
              HomeLayoutBloc.get(context).add(GetAllTasksEvent());
              titleController.clear();
              descriptionController.clear();
              HomeLayoutBloc.get(context).add(ChoosepreiortyEvent(priority: 0));
              HomeLayoutBloc.get(context).add(
                  GetAllTasksAtDay(time: HomeLayoutBloc.get(context).time));
              Navigator.pop(context);
            }, state.categories, HomeLayoutBloc.get(context),
                Locale(strings.localeName));
          }
        },
        builder: (context, state) {
          final bloc = HomeLayoutBloc.get(context);

          final colors = Theme.of(context).colorScheme;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: bloc.pageController,
              children: [
                HomeTab(
                    bloc,
                    state.tasks ?? [],
                    state.user ??
                        UserDb(
                            name: 'name',
                            image: Uint8List(0),
                            password: 'password')),
                CalenderTab(state.tasksAtDay ?? [], bloc),
                const ProgressTab(),
                ProfileTab(
                    state.user ??
                        UserDb(
                            name: 'name',
                            image: Uint8List(0),
                            password: 'password'),
                    bloc),
              ],
              onPageChanged: (index) {
                bloc.add(ChangePageEvent(index: index));
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                bloc.pageController.jumpToPage(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.home),
                  label: strings.home,
                  activeIcon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.home),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.calendar),
                  label: strings.calender,
                  activeIcon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.calendar),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.clock),
                  label: strings.progress,
                  activeIcon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.clock),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.profile),
                  label: strings.profile,
                  activeIcon: Image.asset(
                      color: Theme.of(context).cardColor, AppImages.profile),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                bloc.add(ShowAddTaskEvent());
              },
              shape: const OvalBorder(),
              backgroundColor: colors.secondary,
              child: Icon(Icons.add, size: 32.r),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
