abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsChangeBottomNavState extends NewsStates {}

class NewsGetBusniessLoadingState extends NewsStates {}

class NewsGetBusniessSuccessState extends NewsStates {}

class NewsGetBusniessErrorState extends NewsStates {
  final String error;

  NewsGetBusniessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {

  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsChangeModeState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {

  final String error;

  NewsGetSearchErrorState(this.error);
}