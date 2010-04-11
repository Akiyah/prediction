class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all
    @user = current_user

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @questions }
#    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    @user = current_user
    @bet = current_bet(@user, @question)

#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @question }
#    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @question }
#    end
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
      @bet.destroy
      @bet = nil
    else
      @bet = Bet.create
      @bet.point = params[:bet_point]
      @bet.answer_index = params[:answer_index]
      @bet.user = @user
      @bet.question = @question
      @bet.save
    end

    redirect_to(@question)
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to(questions_url)
#    respond_to do |format|
#      format.html { redirect_to(questions_url) }
#      format.xml  { head :ok }
#    end
  end

  def current_bet(user, question)
    return nil if user == nil
    p user
    p question
    return Bet.find(:first,
                    :conditions=>["user_id = #{user.id} and question_id = #{question.id}"])
  end
end
