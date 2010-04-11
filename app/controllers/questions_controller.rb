class QuestionsController < ApplicationController
  # GET /questions
  def index
    @questions = Question.all
    @user = current_user
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    @user = current_user
    @bet = current_bet(@user, @question)
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])

    if @question.save
      flash[:notice] = 'Question was successfully created.'
      redirect_to(@question)
    else
      render :action => "new"
    end
  end

  # PUT /questions/1
  def update
    @question = Question.find(params[:id])

    @question.update_attributes(params[:question])
    
    redirect_to(@question)
  end

  def change_bet
    @user = current_user
    @question = Question.find(params[:id])
    @bet = current_bet(@user, @question)

    if @bet
      @user.point += @bet.point
      @bet.destroy
      @bet = nil
    else
      @bet = Bet.create
      bet_point = params[:bet_point].to_i
      @user.point -= bet_point
      @bet.point = bet_point
      @bet.answer_index = params[:answer_index]
      @bet.user = @user
      @bet.question = @question
      @bet.save
    end
    @user.save

    redirect_to(@question)
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to(questions_url)
  end

  def current_bet(user, question)
    return nil if user == nil
    return Bet.find(:first,
                    :conditions=>["user_id = #{user.id} and question_id = #{question.id}"])
  end
end
