Verne::Application.routes.draw do
  
  root :to => "wiki#index"

  get "/view/:wiki_id(/:page)", to: "wiki#view", defaults: { page: "index" }
  get "/edit/:wiki_id(/:page)", to: "wiki#edit"
  post "/save/:wiki_id(/:page)", to: "wiki#save"
  get "/delete/:wiki_id(/:page)", to: "wiki#delete"
  get "/file/:wiki_id/*file", to: "wiki#file", :format => false
  
end
