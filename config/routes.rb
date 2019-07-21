Rails.application.routes.draw do
  root 'diplomas_for_contributors#index'
  get 'diplomas_for_contributors/index'
  get 'diplomas_for_contributors/search_contributors' 
  get 'diplomas_for_contributors/generate_pdf' => 'diplomas_for_contributors#generate_pdf',as: 'generate_pdf'
  get 'diplomas_for_contributors/generate_zip_archive' => 'diplomas_for_contributors#generate_zip_archive',as: 'generate_zip_archive'
  get 'diplomas_for_contributors/wrong_link' => 'diplomas_for_contributors#wrong_link',as: 'wrong_link'
end
