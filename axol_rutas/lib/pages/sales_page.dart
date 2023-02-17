// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:axol_rutas/settings/theme.dart';
import 'package:axol_rutas/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:axol_rutas/settings/format.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final _future = Supabase.instance.client
      .from('sales')
      .select<List<Map<String, dynamic>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorPalette.primary,
        elevation: 8,
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.add,
          color: ColorPalette.primaryText,
          size: 24,
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryBackground,
        automaticallyImplyLeading: false,
        // ignore: prefer_const_constructors
        title: Text(
          'Ventas',
          style: Typo.title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final listData = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: listData.length,
                itemBuilder: ((context, index) {
                  final elementList = listData[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                          color: ColorPalette.secondaryBackground,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: ColorPalette.secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                    )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 0, 0),
                                      child: Text(
                                        elementList['client_name'],
                                        style: Typo.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            FormatDate.dmy(elementList['time']),
                                            style: Typo.bodyText2,
                                          ),
                                          Text(
                                            elementList['sale_id'],
                                            style: Typo.bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.navigate_next,
                                    size: 30,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ColorPalette.secondaryBackground,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      FormatNumber.decimal(
                                          elementList['total_quantity']),
                                      style: Typo.bodyText3,
                                    ),
                                    Text(
                                      'Cantidad',
                                      style: Typo.labelText2,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ColorPalette.secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          FormatNumber.decimal(
                                              elementList['total_weight']),
                                          style: Typo.bodyText3,
                                        ),
                                        Text(
                                          'kg',
                                          style: Typo.bodyText3,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Peso total',
                                      style: Typo.labelText2,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ColorPalette.secondaryBackground,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$',
                                          style: Typo.bodyText3,
                                        ),
                                        Text(
                                          FormatNumber.decimal(
                                              elementList['total_price']),
                                          style: Typo.bodyText3,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Precio total',
                                      style: Typo.labelText2,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
