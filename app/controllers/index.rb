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
      body: "#{body} from #{name}",
      via: :smtp,
      via_options: {
        address: 'smtp.gmail.com',
        port: '587',
        enable_starttls_auto: true,
        user_name: ENV['GMAIL_USERNAME'],
        password: ENV['GMAIL_PASSWORD'],
        authentication: :plain,
        domain: "localhost:9292"
      }
    })
    flash[:success] = "Thanks for your email suggestion!"
    redirect '/'
  end
end
