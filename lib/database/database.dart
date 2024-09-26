import 'dart:async';

import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:barcelonaroom/obj/sql/formdatamodeldao_formulario.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

part 'database.g.dart';

@Database(version: 1, entities:
[Apartamento])

abstract class AppDatabase extends FloorDatabase {
  FormDataModelDaoApartamento get  formDataModelDaoApartamento;
}