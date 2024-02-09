import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quiz_app/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestResultView extends StatelessWidget {
  const TestResultView(
      {super.key,
      required this.totalQuestionCount,
      required this.trueAnswerCount});

  final int totalQuestionCount;
  final int trueAnswerCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: AppColors.C_EEEFF2,
          border: Border.all(width: 1, color: AppColors.C_EEEFF2),
          borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        children: [
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            reverse: true,
            radius: 55.0.r,
            lineWidth: 8.0,
            animation: true,
            animationDuration: 1000,
            percent: trueAnswerCount / totalQuestionCount,
            center: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "$trueAnswerCount",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 24.sp),
                  children: <TextSpan>[
                    TextSpan(
                      text: "/$totalQuestionCount\nyour score",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                    )
                  ]),
            ),
            progressColor: AppColors.C_ABD1C6,
            backgroundColor: AppColors.C_004643.withOpacity(0.4),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
              child: RichText(
            text: TextSpan(
                text: "Congratulation! You have ",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                children: <TextSpan>[
                  ((trueAnswerCount / totalQuestionCount) * 100) >= 60
                      ? TextSpan(
                          text: "passed",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.greenAccent,fontSize: 18.sp))
                      : TextSpan(
                          text: " failed ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,fontSize:18.sp)),
                  TextSpan(
                    text: " this test with ",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                  ),
                  TextSpan(
                    text: "${((trueAnswerCount / totalQuestionCount)*100).toStringAsFixed(2)}%",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.greenAccent
                    )
                  )
                ]),
          )),
        ],
      ),
    );
  }
}
