import 'package:barcelonaroom/obj/OBJapartamentos.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoApartamento {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModelApartamento(Apartamento formDataModel);

  @Query('SELECT * FROM Apartamento')
  Future<List<Apartamento>> findFormDataModel();

  @Query('DELETE * FROM Apartamento')
  Future<int?> BorrarTodo();

}