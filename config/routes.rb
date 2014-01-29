Door::Application.routes.draw do
  post "unlock", :to => "entries#create"
end
