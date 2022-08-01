import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:must_do/core/constants/text_styles.dart';
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
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 65),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'My Day',
                    style: heading1,
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 55, 55, 55)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      minLeadingWidth: 10,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      title: const Text(
                        'Make a simple UI, and also add many things into it.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                        ),
                      ),
                      leading: Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
