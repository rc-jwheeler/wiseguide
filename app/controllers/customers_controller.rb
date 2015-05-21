class CustomersController < ApplicationController
  load_and_authorize_resource

  def index
    @customers = @customers.paginate :page => params[:page], :order => [:last_name, :first_name]
  end

  def show
    prep_edit
  end
  
  def download_small_portrait
    send_file(@customer.portrait.path(:small), :type => @customer.portrait_content_type, :disposition => 'inline') if @customer.portrait.path(:small)
  end

  def download_original_portrait
    send_file(@customer.portrait.path(:original), :type => @customer.portrait_content_type) if @customer.portrait.path(:small)
  end

  def new
    if !params[:assessment_request].nil? then
      @assessment_request = params[:assessment_request]
    end
    prep_edit
  end

  def create
    if !params[:assessment_request].nil? then
      @assessment_request = params[:assessment_request]
    end

    if @customer.save
      notice = 'Customer was successfully created.'
      if !@assessment_request.nil? then
        request = AssessmentRequest.find(@assessment_request)
        request.customer = @customer
        request.save!
        redirect_to :controller=>:assessment_requests, :action=>:show,
                    :id=>params[:assessment_request], :notice=>notice
      else
        redirect_to(@customer, :notice => notice) 
      end
    else
      prep_edit
      render :action => "new"
    end
  end

  def update
    if @customer.update_attributes(customer_params)
      redirect_to(@customer, :notice => 'Customer was successfully updated.') 
    else
      prep_edit
      render :action => "show"
    end
  end

  def destroy
    @customer.destroy
    redirect_to(customers_url, :notice => 'Customer was successfully deleted.')
  end
  
  def search
    term = params[:name].downcase.strip
    
    @customers = Customer.search(term).paginate( :page => params[:page], :order => [:last_name, :first_name])

    respond_to do |format|
      format.html { render :action => :index }
      format.json { render :json => @customers }
    end
  end

  private
  
  def prep_edit
    @ethnicities = Ethnicity.all
    @genders = ALL_GENDERS
    @counties = (County.all.collect {|c| c.name} << @customer.county).compact.uniq.sort
    @ada_service_eligibility_statuses = AdaServiceEligibilityStatus.order(:name).all
  end
  
  def customer_params
    params.require(:customer).permit(
      :ada_service_eligibility_status_id,
      :address,
      :birth_date,
      :city,
      :county,
      :email,
      :ethnicity_id,
      :first_name,
      :gender,
      :honored_citizen_cardholder,
      :last_name,
      :middle_initial,
      :notes,
      :phone_number_1,
      :phone_number_1_allow_voicemail,
      :phone_number_2,
      :phone_number_2_allow_voicemail,
      :phone_number_3,
      :phone_number_3_allow_voicemail,
      :phone_number_4,
      :phone_number_4_allow_voicemail,
      :portrait,
      :primary_language,
      :spouse_of_veteran_status,
      :state,
      :veteran_status,
      :zip,
    )
  end
end
