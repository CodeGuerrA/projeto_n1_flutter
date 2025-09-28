import 'package:flutter/material.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/recovery_screen.dart';
import 'screens/tasks/tasks_list_screen.dart';
import 'screens/tasks/task_form_screen.dart';
import 'screens/tasks/subtasks_screen.dart';
import 'screens/categories/categories_list_screen.dart';
import 'screens/categories/category_form_screen.dart';
import 'screens/main/main_screen.dart';

class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const recovery = '/recovery';
  static const tasks = '/tasks';
  static const taskForm = '/task_form';
  static const subtasks = '/subtasks';
  static const categories = '/categories';
  static const categoryForm = '/category_form';

  static final routes = <String, WidgetBuilder>{
    splash: (c) => SplashScreen(),
    onboarding: (c) => OnboardingScreen(),
    login: (c) => LoginScreen(),
    register: (c) => RegisterScreen(),
    recovery: (c) => RecoveryScreen(),
    tasks: (c) => MainScreen(),
    taskForm: (c) => TaskFormScreen(),
    subtasks: (c) => SubtasksScreen(),
    categories: (c) => CategoriesListScreen(),
    categoryForm: (c) => CategoryFormScreen(),
  };
}
