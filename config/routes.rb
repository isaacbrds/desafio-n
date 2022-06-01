Rails.application.routes.draw do
  post "/parking", to: "parkings#create"
  put "/parking/:id/out", to: "parkings#out"
  put "/parking/:id/paid", to: "parkings#paid"
  get "/parking/:plate", to: "parkings#history"
end
