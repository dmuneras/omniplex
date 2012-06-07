Practica::Application.routes.draw do
  
   match "/search" => "searches#search"
   match "/update_multiplex" => "searches#update_multiplex"
   match "/search_multiplex" => "searches#search_multiplex"
   root :to => 'searches#index'
end
