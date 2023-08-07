import 'package:axol_rutas/identities/shoppingcart/view/controllers/rc_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/customer_select/custselc_cubit/custselec_cubit.dart';
import '../../../cubit/customer_select/finder_customer_cubit.dart';
import '../../../cubit/shoppingcart_view_cubit/shoppingcart_view_cubit.dart';
import '../../../model/route_customer_model.dart';

class TxtCustomerName extends StatelessWidget {
  final String customer;

  const TxtCustomerName({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder:(context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => CustselecCubit()),
              BlocProvider(create: (_) => FinderCustomerCubit()),
            ], 
            child: RcSelectController(),
          ), 
        ).then((value) {
          final RouteCustomerModel rcModel;
          if (value != null) {
            rcModel = value;
            context.read<ShoppingcartViewCubit>().load(rcModel.name);
          }
        });
      },
      child: Row(children: [
        Text(customer),
        const Icon(Icons.keyboard_arrow_down),
      ]),
    );
    /*TextFormField(
      onChanged: (value) {
        context.read<TxtCustomerNameCubit>().change(value);
      },
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Nombre del cliente',
        hintStyle: Typo.hintText,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: ColorPalette.secondaryBackground,
      ),
    );*/
  }
}
