import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:must_do/core/constants/text_styles.dart';
import 'package:must_do/core/models/tasks/tasks_model.dart';
import 'package:must_do/screens/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/desert-stars1.jpg',
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'My Day',
                          style: heading1,
                        ),
                        GestureDetector(
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                            onTap: () {
                              model.logout();
                            })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: RichText(
                        text: TextSpan(
                          text: '${model.weekday(model.todaysDate)}, ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${model.month(model.todaysDate)} ${model.monthDay(model.todaysDate)}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    model.taskDataLoading
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: model.tasksTodo.length,
                            itemBuilder: ((context, index) {
                              final item = model.tasksTodo[index].task;
                              return Dismissible(
                                key: Key(item!),
                                onDismissed: (direction) {
                                  model.removeTask(
                                      index, model.tasksTodo[index].isDone!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('$item dismissed')));
                                },
                                background: Container(
                                  color: Colors.red.withOpacity(0.2),
                                ),
                                child: taskTile(index, model.tasksTodo, model),
                              );
                            }),
                          ),
                    if (model.completedTasks.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Icon(
                                  model.showCompletedTasks
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  model.toggleTaskVisibility();
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Completed ${model.completedTasks.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (model.completedTasks.isNotEmpty)
                      if (model.showCompletedTasks == true)
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: model.completedTasks.length,
                          itemBuilder: ((context, index) {
                            return taskTile(index, model.completedTasks, model);
                          }),
                        ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.7),
              elevation: 2,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      // You can wrap this Column with Padding of 8.0 for better design
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: Colors.white70,
                          autofocus: true,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.sp,
                          ),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              model.addTask(value);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container taskTile(int index, List<Task> tasks, HomeViewModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        // color: const Color.fromARGB(255, 55, 55, 55),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        minLeadingWidth: 10.w,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        title: Text(
          tasks[index].task!,
          style: TextStyle(
            color: tasks[index].isDone! ? Colors.white70 : Colors.white,
            fontSize: 16.5.sp,
            decoration:
                tasks[index].isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: GestureDetector(
          child: Container(
            height: 23.h,
            width: 23.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tasks[index].isDone! ? Colors.white60 : Colors.transparent,
              border: Border.all(
                color: tasks[index].isDone! ? Colors.white60 : Colors.white,
                width: 2.w,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: tasks[index].isDone! ? Colors.black : Colors.transparent,
                size: 17,
              ),
            ),
          ),
          onTap: () {
            model.toggleIsDone(
              index,
              tasks[index].isDone!,
              tasks[index],
            );
          },
        ),
      ),
    );
  }
}
