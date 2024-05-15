import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class StazeProvider extends BaseProvider<Staze> {
  StazeProvider() : super("Staze");

  @override
  Staze fromJson(data) {
    return Staze.fromJson(data);
  }
}
