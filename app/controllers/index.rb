class TechIncident < Sinatra::Base
  get '/style.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss :style
  end

  get '/' do
    erb :index
  end
end
