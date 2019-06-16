Rails.application.routes.draw do

  post   '/users/new'             => 'user#new'
  post   '/sessions/create'       => 'authentication#create'
  post   '/sessions/refresh'      => 'authentication#refresh'
  post   '/sessions/destroy'      => 'authentication#destroy'
end
