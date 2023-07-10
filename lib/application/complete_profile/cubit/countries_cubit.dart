import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesCubit extends Cubit<List<String>>{
  CountriesCubit():super([]);

  static List<String> countries = [];

  onAddCountry(String value){
    countries.add(value);
    emit(countries);
  }

  onCountriesAdded(){
    countries.sort(
          (a, b) => a.toLowerCase().compareTo(
        b.toLowerCase(),
      ),
    );
    emit(countries);
  }
}