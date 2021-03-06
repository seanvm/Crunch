class IssuesController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update, :index, :destroy]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully logged.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update    
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def review
    # TODO - Add security for state updates
    @issue = Issue.find(params[:issue_id])
    if @issue.review!
      flash.now[:success] = 'Issue in review'
      render :template => 'issues/update_state'
    end
  end
  
  def confirm
    # TODO - Add security for state updates
    @issue = Issue.find(params[:issue_id])
    if @issue.confirm! && @issue.post_to_JIRA
      flash.now[:success] = 'Issue has been confirmed'
      render :template => 'issues/update_state'
    else 
      flash.now[:danger] = 'Error updating issue'
      render :template => 'issues/update_state'
    end
  end
  
  def development
    # TODO - Add security for state updates
    @issue = Issue.find(params[:issue_id])
    if @issue.development!
      flash.now[:success] = 'Issue in development'
      render :template => 'issues/update_state'
    else 
      flash.now[:danger] = 'Error updating issue'
      render :template => 'issues/update_state'
    end
  end
  
  def complete
    # TODO - Add security for state updates
    @issue = Issue.find(params[:issue_id])
    @issue.update_attribute(:completed_at, DateTime.now)
    if @issue.completed!
      flash.now[:success] = 'Issue completed'
      render :template => 'issues/update_state'
    else 
      flash.now[:danger] = 'Error updating issue'
      render :template => 'issues/update_state'
    end
  end
  
  def unverified
    # TODO - Add security for state updates
    @issue = Issue.find(params[:issue_id])
    if @issue.unverified!
      flash.now[:success] = 'Issue no longer verified'
      render :template => 'issues/update_state'
    else 
      flash.now[:danger] = 'Error updating issue'
      render :template => 'issues/update_state'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:title,  :description, :severity, :external_url)
    end
    
    def logged_in_user
      super
    end
end
