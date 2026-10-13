import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/latihangridlist/ListScreen.dart';
import 'package:flutter_salwa_rpl1/pages/about_page.dart';
import 'package:flutter_salwa_rpl1/pages/home_page.dart';
//list
import 'package:flutter_salwa_rpl1/list_view/ListView.dart';
import 'package:flutter_salwa_rpl1/list_view/ListViewBuilder.dart';
import 'package:flutter_salwa_rpl1/list_view/ListViewHorizontal.dart';
import 'package:flutter_salwa_rpl1/list_view/ListViewTerpisah.dart';
import 'package:flutter_salwa_rpl1/list_view/ListViewWidgetKustom.dart';
import 'package:flutter_salwa_rpl1/list_view/TugasSatuListView.dart';
//row
import 'package:flutter_salwa_rpl1/row_colum/ColumnWidget.dart';
import 'package:flutter_salwa_rpl1/row_colum/LatihanDua.dart';
import 'package:flutter_salwa_rpl1/row_colum/LatihanSatu.dart';
import 'package:flutter_salwa_rpl1/row_colum/RowColumnWidget.dart';
import 'package:flutter_salwa_rpl1/row_colum/RowWidget.dart';
//sized_expanded_stack
import 'package:flutter_salwa_rpl1/sized_expanded_stack/expandedWidget.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/LatihanEmpat.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/LayoutDua.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/LayoutEmpat.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/LayoutSatu.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/LayoutTiga.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/SizedBoxWidget.dart';
import 'package:flutter_salwa_rpl1/sized_expanded_stack/stackWidget.dart';








class AppRoutes {
  static const home  = '/';
  static const listScreen  = '/list-Screen';
  static const about  = '/about';
  //list
  static const listView = '/ListView';
  static const listViewBuilder = '/ListViewBuilder';
  static const listViewHorizontal = '/ListViewHorizontal';
  static const listViewTerpisah = '/ListViewTerpisah';
  static const listViewWidgetKustom = '/ListViewWidgetKustom';
  static const tugasSatuListView = '/TugasSatuListView';
  //row
  static const columnWidget = '/ColumnWidget';
  static const latihanDua = '/LatihanDua';
  static const latihanSatu = '/LatihanSatu';
  static const rowColumnWIdget = '/RowColumnWidget';
  static const rowWidget = '/RowWidget';
  //sized_expanded_stack
  static const expandedWidget = '/ExpandedWidget';
  static const latihanEmpat = '/LatihanEmpat';
  static const layoutDua = '/LayoutDua';
  static const layoutEmpat = '/LayoutEmpat';
  static const layoutSatu = '/LayoutSatu';
  static const layoutTiga = '/LayoutTiga';
  static const sizedBoxWidget = '/SizedBoxWidget';
  static const stackWidget = '/StackWidget';
  
  
  
  static Map<String , WidgetBuilder> routes = {
    home: (context) =>  HomePage(),
    listScreen: (context) =>  ArticleListScreen(),
    about: (context) =>  AboutPage(),
    listView:(context) => ListViewWidget(),
    //list
    listViewBuilder:(context) => ListViewBuilderWidget(),
    listViewHorizontal:(context) => ListViewHorizontal(),
    listViewTerpisah:(context) => ListviewTerpisah(),
    listViewWidgetKustom:(context) => ListViewWidgetKustom(),
    tugasSatuListView:(context) => TugasSatuListView(),
    //row
    columnWidget:(context) => ColumnWidget(),
    latihanDua:(context) => LatihanDua(),
    latihanSatu:(context) => LatihanSatu(),
    rowColumnWIdget:(context) => RowColumnWidget(),
    rowWidget:(context) => RowWidget(),
    //sized_expanded_stack
    expandedWidget:(context) => ExpandedWidget(),
    latihanEmpat:(context) => LatihanEmpat(),
    layoutDua:(context) => LayoutDua(),
    layoutEmpat:(context) => ProfileWidget(),
    layoutSatu:(context) => LayoutSatu(),
    layoutTiga:(context) => LatihanTiga(),
    sizedBoxWidget:(context) => SizedBoxWidget(),
    stackWidget:(context) => StackWidget(),
    
  };

}