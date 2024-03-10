// ignore_for_file: constant_identifier_names

enum GenderEnum { MALE, FEMALE }

final Map<String, GenderEnum?> toGenderENUM = {
  'Femenino': GenderEnum.FEMALE,
  'Masculino': GenderEnum.MALE,
  '': null,
};

final Map<GenderEnum, String> toGenderString = {
  GenderEnum.FEMALE: 'Femenino',
  GenderEnum.MALE: 'Masculino',
};
