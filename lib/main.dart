import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontodevenda/presentation/screens/admin_login_screen.dart';
import 'package:pontodevenda/presentation/screens/home_screen.dart';
import 'package:pontodevenda/presentation/screens/product_screen.dart';
import 'package:pontodevenda/presentation/screens/seller_selection_screen.dart';
import 'package:pontodevenda/repository/admin/admin_repository.dart';
import 'package:pontodevenda/repository/admin/admin_repository_impl.dart';
import 'package:pontodevenda/repository/login/login_repository.dart';
import 'package:pontodevenda/repository/login/login_repository_impl.dart';
import 'package:pontodevenda/repository/payment/payment_repository.dart';
import 'package:pontodevenda/repository/payment/payment_repository_impl.dart';
import 'package:pontodevenda/repository/product/product_repository.dart';
import 'package:pontodevenda/repository/product/product_repository_impl.dart';
import 'package:pontodevenda/repository/user/user_repository.dart';
import 'package:pontodevenda/repository/user/user_repository_impl.dart';
import 'package:pontodevenda/service/bloc/admin/admin_bloc.dart';
import 'package:pontodevenda/service/bloc/login/login_bloc.dart';
import 'package:pontodevenda/service/bloc/payment/payment_bloc.dart';
import 'package:pontodevenda/service/bloc/product/product_bloc.dart';
import 'package:pontodevenda/service/bloc/user/user_bloc.dart';

import 'common/api/dio_api_client.dart';
import 'common/theme/app_theme.dart';

void main() {
  final apiClient = DioApiClient();
  final userRepository = UserRepositoryImpl(apiClient);
  final productRepository = ProductRepositoryImpl(apiClient);
  final loginRepository = LoginRepositoryImpl(apiClient);
  final paymentRepository = PaymentRepositoryImpl(apiClient);
  final adminRepository = AdminRepositoryImpl(apiClient);

  runApp(
    MyApp(
      userRepository: userRepository,
      productRepository: productRepository,
      loginRepository: loginRepository,
      paymentRepository: paymentRepository,
      adminRepository: adminRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final ProductRepository productRepository;
  final LoginRepository loginRepository;
  final PaymentRepository paymentRepository;
  final AdminRepository adminRepository;

  const MyApp({
    super.key,
    required this.userRepository,
    required this.productRepository,
    required this.loginRepository,
    required this.paymentRepository,
    required this.adminRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(userRepository)),
        BlocProvider(create: (context) => ProductBloc(productRepository)),
        BlocProvider(create: (context) => LoginBloc(loginRepository)),
        BlocProvider(create: (context) => PaymentBloc(paymentRepository)),
        BlocProvider(create: (context) => AdminBloc(adminRepository)),
      ],
      child: MaterialApp(
        title: 'Vendedor Selection',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/seller_selecion': (context) => SellerSelectionScreen(),
          '/admin_login': (context) => AdminLoginScreen(),
          '/products': (context) => ProductScreen(),
        },
      ),
    );
  }
}
