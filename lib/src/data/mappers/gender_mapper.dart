import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class GenderMapper {
  static Gender toEntity(String gender) => Gender(
        value: gender,
        type: toGenderENUM[gender]!,
      );
}
