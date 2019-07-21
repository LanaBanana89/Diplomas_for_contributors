require 'spec_helper'

RSpec.describe DiplomasForContributorsController, type: :controller do
  describe "GET #index" do    
    it "returns a success response" do
      get :index

      expect(response.status).to eq(200)      
    end
  end

  describe "GET #search_contributors" do
    it "success search contributors" do      
      get :search_contributors, { search_params: { link: "https://github.com/rails/rails" } }

      contributor_names = assigns(:contributor_names)      

      expect(contributor_names).not_to be_empty      
      expect(response).to render_template('search_contributors')
    end

    it "failure search contributors" do      
      get :search_contributors, { search_params: { link: "https://yandex.ru" } }

      contributor_names = assigns(:contributor_names)

      expect(contributor_names).to be_nil
      expect(response).to redirect_to(wrong_link_path)
    end
  end

  describe "get_pdf_bytes" do
    it "success generate pdf" do
      get_pdf_bytes = controller.send(:get_pdf_bytes, 1, 'superman')      
      expect(get_pdf_bytes).to be      
    end
  end

  describe "generate_zip_archive " do
    it "success generate zip archive" do
      get :generate_zip_archive, { contributor_names: ["batman", "supermen", "spiderman"] }
      expect(response.status).to eq(200)     
    end    
  end

  describe "routing" do
    it 'routes GET /search_contributors to DiplomasForContributorsController#search_contributors' do
      expect(get: 'diplomas_for_contributors/search_contributors').to route_to(controller: 'diplomas_for_contributors', action: 'search_contributors')
    end
    
    it 'routes GET /generate_pdf to DiplomasForContributorsController#generate_pdf' do
      expect(get: 'diplomas_for_contributors/generate_pdf').to route_to(controller: 'diplomas_for_contributors', action: 'generate_pdf')
    end

    it 'routes GET /generate_pdf to DiplomasForContributorsController#generate_zip_archive' do
      expect(get: 'diplomas_for_contributors/generate_zip_archive').to route_to(controller: 'diplomas_for_contributors', action: 'generate_zip_archive')
    end
  end
end
