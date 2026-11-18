import 'package:flutter/material.dart';

import '../screens/auth/choose_role_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/food/food_details_screen.dart';
import '../screens/food/food_menu_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/main_navigation_screen.dart';
import '../screens/location/confirm_location_screen.dart';
import '../screens/location/enable_location_screen.dart';
import '../screens/onboarding/menu_intro_screen.dart';
import '../screens/onboarding/subscription_intro_screen.dart';
import '../screens/orders/my_orders_screen.dart';
import '../screens/orders/order_tracking_screen.dart';
import '../screens/payment/payment_screen.dart';
import '../screens/payment/payment_success_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/subscription/choose_package_screen.dart';
import '../screens/subscription/plan_details_screen.dart';
import '../screens/subscription/subscription_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String chooseRole = '/choose-role';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String menuIntro = '/menu-intro';
  static const String subscriptionIntro = '/subscription-intro';
  static const String mainNavigation = '/main-navigation';
  static const String home = '/home';
  static const String subscription = '/subscription';
  static const String planDetails = '/plan-details';
  static const String choosePackage = '/choose-package';
  static const String foodMenu = '/food-menu';
  static const String foodDetails = '/food-details';
  static const String enableLocation = '/enable-location';
  static const String confirmLocation = '/confirm-location';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String myOrders = '/my-orders';
  static const String orderTracking = '/order-tracking';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        chooseRole: (context) => const ChooseRoleScreen(),
        login: (context) => const LoginScreen(),
        otp: (context) => const OtpScreen(),
        menuIntro: (context) => const MenuIntroScreen(),
        subscriptionIntro: (context) => const SubscriptionIntroScreen(),
        mainNavigation: (context) => const MainNavigationScreen(),
        home: (context) => const HomeScreen(),
        subscription: (context) => const SubscriptionScreen(),
        planDetails: (context) => const PlanDetailsScreen(),
        choosePackage: (context) => const ChoosePackageScreen(),
        foodMenu: (context) => const FoodMenuScreen(),
        foodDetails: (context) => const FoodDetailsScreen(),
        enableLocation: (context) => const EnableLocationScreen(),
        confirmLocation: (context) => const ConfirmLocationScreen(),
        payment: (context) => const PaymentScreen(),
        paymentSuccess: (context) => const PaymentSuccessScreen(),
        myOrders: (context) => const MyOrdersScreen(),
        orderTracking: (context) => const OrderTrackingScreen(),
        profile: (context) => const ProfileScreen(),
      };
}
