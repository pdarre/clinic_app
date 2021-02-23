import 'package:clinic_app/models/beds_model.dart';
import 'package:clinic_app/repositories/bed_repository.dart';

class BedProvider {
  final BedRepository _bedRepository;
  const BedProvider(this._bedRepository);

  Future<Bed> getBedByIdBed(String idBed) {
    return _bedRepository.getBedByIdBed(idBed);
  }
}
