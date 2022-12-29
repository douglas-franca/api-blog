Rails.application.routes.draw do
  # resources :users, only: %i[create update delete]
  get '/user', to: 'users#show'
  post '/user', to: 'users#create'
  put '/user', to: 'users#update'
  patch '/user', to: 'users#update'
  delete '/user', to: 'users#destroy'

  get '/user', to: 'users#show'
  post '/user', to: 'users#create'
  put '/user', to: 'users#update'
  patch '/user', to: 'users#update'
  delete '/user', to: 'users#destroy'

  post '/posts/:post_id/like', to: 'likes#create_like_post'
  delete '/posts/:post_id/like/:id', to: 'likes#destroy_like_post'
  post '/posts/:post_id/comment/:comment_id/like', to: 'likes#create_like_comment'
  delete '/posts/:post_id/comment/:comment_id/like/:id', to: 'likes#destroy_like_comment'

  post '/login', to: 'users#login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts, except: %i(new edit) do
    resources :comments, except: %i(new edit)
  end
  

  # get '/posts', to: 'posts#index'
  # post '/posts', to: 'posts#create'  #arquivo posts, por padrão ele adiciona já _controller para procurar o arquivo e depois do ## coloca a função
  # get '/posts/:id', to: 'posts#show'  
  # patch '/posts/:id', to: 'posts#update'  
  # put '/posts/:id', to: 'posts#update'  
  # delete '/posts/:id', to: 'posts#destroy'
  

  post '/posts/:id/tag', to: 'posts#link_tag'
  delete '/posts/:id/tag', to: 'posts#unlink_tag'
  get '/posts/:id/tags', to: 'posts#tags_vinculadas'

  get '/tags', to: 'tags#index'
  post '/tags', to: 'tags#create'
  get '/tags/:id', to: 'tags#show'  
  patch '/tags/:id', to: 'tags#update'
  put '/tags/:id', to: 'tags#update'  
  delete '/tags/:id', to: 'tags#destroy'


  

  



end
