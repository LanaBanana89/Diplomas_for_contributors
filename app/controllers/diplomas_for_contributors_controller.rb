class DiplomasForContributorsController < ApplicationController
  def index
  end

  def search_contributors
    github = Github.new do |config|
      config.auto_pagination = true
    end

    link = params[:search_params][:link] 
    
    if link.empty?
      redirect_to root_path
      return
    end
    
    unless (link =~ /^(https|http):\/\/github.com\/(.+?)\/(.+?)$/ && $2 && $3)      
      redirect_to wrong_link_path
      return
    end
    
    user = $2
    repo = $3    

    begin
      github_contributors = github.repos.stats.contributors user, repo
    rescue
      redirect_to wrong_link_path
      return
    end

    contributors = github_contributors.to_a

    if contributors
      @contributor_names = contributors.collect{ |contributor| contributor[:author][:login] }.pop(3).reverse      
    end   
  end

  def generate_pdf
    send_data(get_pdf_bytes(params[:number],params[:name]),filename: "#{params[:name]}.pdf")  
  end

  def generate_zip_archive   
    stringio = Zip::OutputStream.write_buffer do |zio|
      params[:contributor_names].each_with_index do |c_name, index|
        zio.put_next_entry("#{c_name}.pdf")
        zio.write get_pdf_bytes(index + 1, c_name)
      end
    end
   
    send_data stringio.string, filename: "archive.zip", type: 'application/zip'   
  end

  def wrong_link
  end

  private 
 
  def get_pdf_bytes(number,c_name)
    kit = PDFKit.new(<<-HTML)
      <h1 class="content_pdf">PDF ##{number}</h1>
      <h2 class="content_pdf">The award goes to</h2>
      <p class="content_pdf">#{c_name}</p>
    HTML
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.css"
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/diplomas_for_contributors.css"
    kit.to_pdf
  end
end
