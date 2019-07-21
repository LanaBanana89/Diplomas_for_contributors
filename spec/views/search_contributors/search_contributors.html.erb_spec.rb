require File.dirname(__FILE__) + '/../../spec_helper'

RSpec.describe 'diplomas_for_contributors/search_contributors', type: :view do
  before(:each) do
    assign(:contributor_names, ["batman", "supermen", "spiderman"])        
  end
  it 'renderes name of contributors' do
    render 
    
    expect(rendered).to match "batman"
    expect(rendered).to match "supermen"
    expect(rendered).to match "spiderman"
    expect(rendered).to match "download.pdf"
  end
end