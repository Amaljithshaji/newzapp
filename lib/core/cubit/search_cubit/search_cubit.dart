import 'package:bloc/bloc.dart';

import '../../models/article.dart';
import '../../repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  SearchCubit({required this.repo}) : super(SearchInitial());

  searchNews({required String search})async{
    emit(SearchLoadingState());
    try{
      final news = await repo.searchNews( search: search);
    emit(SearchSuccessState(news: news));
    }catch(e){
      emit(SearchErrorState(error: e.toString()));
    }
    
  }
}
