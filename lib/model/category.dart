import 'package:voice/constants/keys.dart';
import 'package:voice/constants/strings.dart';

class Category {
  const Category({this.documentName, this.label});

  final String documentName;
  final String label;
}

const List<Category> categories = const <Category>[
  const Category(
      documentName: Keys.DOCUMENT_ANIMAL_RIGHTS,
      label: Strings.label_animal_rights),
  const Category(
      documentName: Keys.DOCUMENT_SAB_GROUPS, label: Strings.label_hunt_sabs),
  const Category(
      documentName: Keys.DOCUMENT_SHELTERS,
      label: Strings.label_shelters),
  const Category(
      documentName: Keys.DOCUMENT_GLOBAL_ORGANISATIONS,
      label: Strings.label_global_orgs),
];
