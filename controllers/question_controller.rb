class QuestionController < Sinatra::Base

  register Auth

  get '/ask', :auth => :user do
    erb :ask
  end
  
  post '/ask', :auth => :user do
  
    user = authorised_user
    title = params[:title]
    message = params[:message]
    
    new_question = Question.new_question(user, title, message)
    
    redirect '/'
    
  end
  
end