Auth::Application.routes.draw do
  root to: "sessions#new"
  get 'sessions/offer'
  get 'sessions/index'
  get 'sessions/show'
  get 'sessions/enter'
  get 'vendors/home'
  get 'vendors/edit'

  get 'vendors/new'
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/logout", to: "vendors#destroy", :as => "logout2"
  resources :sessions
  resources :vendors


























































  get 'sessions/hello'
  get 'sessions/welcome'
  get 'sessions/hello2'
  get 'sessions/welcome2'
  get 'sessions/hello3'
  get 'sessions/welcome3'
  get 'sessions/hello4'
  get 'sessions/welcome4'
  get 'sessions/hello5'
  get 'sessions/welcome5'
  get 'sessions/hello6'
  get 'sessions/welcome6'
  get 'sessions/hello1'
  get 'sessions/welcome1'
  get 'sessions/hello21'
  get 'sessions/welcome21'
  get 'sessions/hello31'
  get 'sessions/welcome31'
  get 'sessions/hello41'
  get 'sessions/welcome41'
  get 'sessions/hello51'
  get 'sessions/welcome51'
  get 'sessions/hello61'
  get 'sessions/welcome61'

  get 'sessions/hello2'
  get 'sessions/welcome2'
  get 'sessions/hello22'
  get 'sessions/welcome22'
  get 'sessions/hello32'
  get 'sessions/welcome32'
  get 'sessions/hello42'
  get 'sessions/welcome42'
  get 'sessions/hello52'
  get 'sessions/welcome52'
  get 'sessions/hello62'
  get 'sessions/welcome62'
  get 'sessions/hello12'
  get 'sessions/welcome12'
  get 'sessions/hello212'
  get 'sessions/welcome212'
  get 'sessions/hello312'
  get 'sessions/welcome312'
  get 'sessions/hello412'
  get 'sessions/welcome412'
  get 'sessions/hello512'
  get 'sessions/welcome512'
  get 'sessions/hello612'
  get 'sessions/welcome612'






  get 'vendors/hello3'
  get 'vendors/welcome3'
  get 'vendors/hello23'
  get 'vendors/welcome23'
  get 'vendors/hello33'
  get 'vendors/welcome33'
  get 'vendors/hello43'
  get 'vendors/welcome43'
  get 'vendors/hello53'
  get 'vendors/welcome53'
  get 'vendors/hello63'
  get 'vendors/welcome63'
  get 'vendors/hello13'
  get 'vendors/welcome13'
  get 'vendors/hello213'
  get 'vendors/welcome213'
  get 'vendors/hello313'
  get 'vendors/welcome313'
  get 'vendors/hello413'
  get 'vendors/welcome413'
  get 'vendors/hello513'
  get 'vendors/welcome513'
  get 'vendors/hello613'
  get 'vendors/welcome613'

  get 'vendors/hello23'
  get 'vendors/welcome23'
  get 'vendors/hello223'
  get 'vendors/welcome223'
  get 'vendors/hello323'
  get 'vendors/welcome323'
  get 'vendors/hello423'
  get 'vendors/welcome423'
  get 'vendors/hello523'
  get 'vendors/welcome523'
  get 'vendors/hello623'
  get 'vendors/welcome623'
  get 'vendors/hello123'
  get 'vendors/welcome123'
  get 'vendors/hello2123'
  get 'vendors/welcome2123'
  get 'vendors/hello3123'
  get 'vendors/welcome3123'
  get 'vendors/hello4123'
  get 'vendors/welcome4123'
  get 'vendors/hello5123'
  get 'vendors/welcome5123'
  get 'vendors/hello6123'
  get 'vendors/welcome6123'
end
