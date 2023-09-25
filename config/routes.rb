Rails.application.routes.draw do
  root "pages#index"

  constraints PathAnalysis.new do
    get "(*page_path)/add", to: "pages#new", as: "pages"
    post "(*page_path)/add", to: "pages#create"
    patch "*page_path/edit", to: "pages#update", as: "page_edit"
    get "*page_path/edit", to: "pages#edit"
    get "*page_path", to: "pages#show", as: "page"
  end
end
