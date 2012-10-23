Verne::Application.routes.draw do
  
  root :to => "start#index"

  post "/project/open" => "project#open"  
  get "/project/view/*file" => "project#view"
  get "/project/edit/*file" => "project#edit"
  post "/project/save" => "project#save"
  
end
