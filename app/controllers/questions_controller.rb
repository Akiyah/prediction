class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])
    @question.answers = []

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

    p "params[:question]"
    p params[:question]

    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    #@question.answers
    params[:question][:answers].split.each do |answer_title|
      @question.answers << Answer.new({:title=>answer_title, :question=> @question})
    end
    @question.save
    
    redirect_to(@question)
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
