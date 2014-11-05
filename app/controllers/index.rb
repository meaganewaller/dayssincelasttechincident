class TechIncident < Sinatra::Base
  get '/style.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss :style
  end

  get '/' do
    erb :index
  end

  get '/credits' do
    erb :credits
  end

  post '/' do
    name = params[:name]
    mail = params[:mail]
    subject = params[:subject]
    body = params[:message]

    Pony.mail({
      to: ENV['DSLTI_EMAIL'],
      from: "#{mail}",
      subject: "DSLTI - New #{subject}",
      body: "#{body} from #{name}"
    })
    flash[:success] = "Thanks for your email suggestion!"
    redirect '/'
  end
end
