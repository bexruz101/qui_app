import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';


class AppTheme{
  static ThemeData lightTheme = ThemeData(
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.black,),
      scaffoldBackgroundColor: AppColors.white,
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.C_004643,
        unselectedItemColor: AppColors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      appBarTheme:  const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark
          )
      ),
      textTheme: const TextTheme(
        //display
          displayLarge: TextStyle(
              color: AppColors.black,
              fontSize: 57,
              fontWeight: FontWeight.w800,
              fontFamily: 'Poppins'
          ),
          displayMedium: TextStyle(
              color: AppColors.black,
              fontSize: 45,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          displaySmall: TextStyle(
              color: AppColors.black,
              fontSize: 36,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
          ),
          //headline
          headlineLarge: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          headlineMedium: TextStyle(
              color: AppColors.black,
              fontSize: 28,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          headlineSmall: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'
          ),
          //title
          titleLarge: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          titleMedium: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
          ),
          titleSmall: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          //label
          labelLarge: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
          ),
          labelMedium: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          labelSmall: TextStyle(
              color: AppColors.black,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          //body
          bodyLarge: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          bodyMedium: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          bodySmall: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          )

      )
  );

  static ThemeData darkTheme = ThemeData(
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.white,),
      scaffoldBackgroundColor: AppColors.black,
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.C_004643,
        unselectedItemColor: AppColors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.black,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light
          )
      ),
      textTheme:  TextTheme(
        //display
          displayLarge: const TextStyle(
              color: AppColors.white,
              fontSize: 57,
              fontWeight: FontWeight.w800,
              fontFamily: 'Poppins'
          ),
          displayMedium: const TextStyle(
              color: AppColors.white,
              fontSize: 45,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          displaySmall: const TextStyle(
              color: AppColors.white,
              fontSize: 36,
              fontWeight: FontWeight.w600,
              fontFamily:'Poppins'
          ),
          //headline
          headlineLarge: const TextStyle(
              color: AppColors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          headlineMedium: const TextStyle(
              color: AppColors.white,
              fontSize: 28,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          headlineSmall: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'
          ),
          //title
          titleLarge: const TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins'
          ),
          titleMedium: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
          ),
          titleSmall: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          //label
          labelLarge: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
          ),
          labelMedium: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily:'Poppins'
          ),
          labelSmall: const TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          //body
          bodyLarge: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          bodyMedium: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          bodySmall: TextStyle(
              color: AppColors.passiveWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          )

      )
  );
}