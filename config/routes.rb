Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    root to: redirect("/admin/chat_videos")
    resources :chat_videos
  end

  namespace :api do
    namespace :v1 do
      resources :chat_videos, param: :slug, only: [ :index, :show ]
    end
  end

  root to: redirect("/admin/chat_videos")
end
