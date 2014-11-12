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
    res = Pony.mail(
      from: params[:name] + "<" + params[:mail] + ">",
      to: ENV["DSLTI_EMAIL"],
      subject: "DSLTI - New #{params[:subject]}",
      body: params[:body],
      via: :smtp,
      via_options: {
        address: 'smtp.sendgrid.net',
        port: '587',
        enable_starttsl_auto: true,
        username: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'],
        authentication: :plain,
        domain: 'heroku.com'
      }
    )
    if res
      flash[:success] = "Thanks for your email suggestion!"
      redirect '/'
    else
      flash[:error] = "The email was not sent successfully. Please try again."
      redirect '/'
    end
  end
end
