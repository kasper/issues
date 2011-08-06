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
  
  get '/view/:id' do
  
    @question = Question.get(params[:id])
    @answers = @question.answers
    erb :view
  
  end
  
  post '/answer/:id', :auth => :user do
  
    user = authorised_user
    question = Question.get(params[:id])
    message = params[:message]
    
    new_answer = Answer.new_answer(user, question, message)
    redirect '/view/' + params[:id]
  
  end
  
end