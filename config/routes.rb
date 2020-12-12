# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :rates, only: :show, param: :date, constraints: { id: /\d{4}-\d{2}-\d{2}/ }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
