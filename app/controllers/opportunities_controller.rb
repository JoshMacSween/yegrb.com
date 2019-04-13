class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: %i[show edit update destroy close]
  before_action :authorize_edit, only: %i[edit update destroy]
  before_action :authorize_read, only: [:show]

  # GET /opportunities
  def index
    if params[:collection] == 'open'
      @opportunities = Opportunity.open.paginate(page: params[:page], per_page: 10)
    elsif params[:collection] == 'closed'
      @opportunities = Opportunity.closed.paginate(page: params[:page], per_page: 10)
    else
      @opportunities = Opportunity.sorted.paginate(page: params[:page], per_page: 10)
    end
    authorize! :read, Opportunity
  end

  # GET /opportunities/1
  def show; end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    @opportunity.user_id = current_user&.id
    authorize! :edit, @opportunity
  end

  # GET /opportunities/1/edit
  def edit; end

  # POST /opportunities
  def create
    @opportunity = Opportunity.new(opportunity_params)
    @opportunity.user_id = current_user&.id
    authorize! :edit, @opportunity
    if @opportunity.save
      flash[:success] = 'Opportunity was successfully created.'
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to create opportunity.'
      render :new
    end
  end

  # PATCH/PUT /opportunities/1
  def update
    if @opportunity.update(opportunity_params)
      flash[:success] = 'Opportunity was successfully updated.'
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to update opportunity'
      render :edit
    end
  end

  # PATCH/PUT /opportunities/1
  def close
    if @opportunity.close!
      flash[:success] = 'Opportunity was successfully closed.'
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to close opportunity'
      render :edit
    end
  end

  # DELETE /opportunities/1
  def destroy
    @opportunity.destroy
    flash[:success] = 'Opportunity was successfully destroyed.'
    redirect_to opportunities_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def authorize_edit
    authorize! :edit, @opportunity
  end

  def authorize_read
    authorize! :read, @opportunity
  end

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_params
    params.require(:opportunity).permit(:user_id, :title, :company, :contact, :email, :paid_position, :content, :good_until)
  end
end
