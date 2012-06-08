Practica::Application.routes.draw do
  
   match "/search" => "searches#search"
   match "/update_multiplex_cinecol" => "searches#update_multiplex"
   match "/update_multiplex_royal" => "royals#update_multiplex"   
   match "/search_multiplex" => "searches#search_multiplex"
   match "/search_multiplex_royal" => "royals#search_multiplex"
   match "/royals" => "royals#index"
   root :to => 'searches#index'
end
