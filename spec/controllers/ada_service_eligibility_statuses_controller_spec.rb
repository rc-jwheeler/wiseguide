require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AdaServiceEligibilityStatusesController do

  # This should return the minimal set of attributes required to create a valid
  # AdaServiceEligibilityStatus. As you add validations to AdaServiceEligibilityStatus, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => "My Name"}
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
  end
  
  describe "GET index" do
    it "assigns all ada_service_eligibility_statuses as @ada_service_eligibility_statuses" do
      ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
      get :index, {}
      assigns(:ada_service_eligibility_statuses).should eq([ada_service_eligibility_status])
    end
  end

  describe "GET show" do
    it "assigns the requested ada_service_eligibility_status as @ada_service_eligibility_status" do
      ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
      get :show, {:id => ada_service_eligibility_status.to_param}
      assigns(:ada_service_eligibility_status).should eq(ada_service_eligibility_status)
    end
  end

  describe "GET new" do
    it "assigns a new ada_service_eligibility_status as @ada_service_eligibility_status" do
      get :new, {}
      assigns(:ada_service_eligibility_status).should be_a_new(AdaServiceEligibilityStatus)
    end
  end

  describe "GET edit" do
    it "assigns the requested ada_service_eligibility_status as @ada_service_eligibility_status" do
      ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
      get :edit, {:id => ada_service_eligibility_status.to_param}
      assigns(:ada_service_eligibility_status).should eq(ada_service_eligibility_status)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdaServiceEligibilityStatus" do
        expect {
          post :create, {:ada_service_eligibility_status => valid_attributes}
        }.to change(AdaServiceEligibilityStatus, :count).by(1)
      end

      it "assigns a newly created ada_service_eligibility_status as @ada_service_eligibility_status" do
        post :create, {:ada_service_eligibility_status => valid_attributes}
        assigns(:ada_service_eligibility_status).should be_a(AdaServiceEligibilityStatus)
        assigns(:ada_service_eligibility_status).should be_persisted
      end

      it "redirects to the created ada_service_eligibility_status" do
        post :create, {:ada_service_eligibility_status => valid_attributes}
        response.should redirect_to(AdaServiceEligibilityStatus.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ada_service_eligibility_status as @ada_service_eligibility_status" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdaServiceEligibilityStatus.any_instance.stub(:save).and_return(false)
        post :create, {:ada_service_eligibility_status => {:name => ''}}
        assigns(:ada_service_eligibility_status).should be_a_new(AdaServiceEligibilityStatus)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdaServiceEligibilityStatus.any_instance.stub(:save).and_return(false)
        post :create, {:ada_service_eligibility_status => {:name => ''}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ada_service_eligibility_status" do
        ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
        # Assuming there are no other ada_service_eligibility_statuses in the database, this
        # specifies that the AdaServiceEligibilityStatus created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AdaServiceEligibilityStatus.any_instance.should_receive(:update_attributes).with({'name' => 'test'})
        put :update, {:id => ada_service_eligibility_status.to_param, :ada_service_eligibility_status => {'name' => 'test'}}
      end

      it "assigns the requested ada_service_eligibility_status as @ada_service_eligibility_status" do
        ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
        put :update, {:id => ada_service_eligibility_status.to_param, :ada_service_eligibility_status => valid_attributes}
        assigns(:ada_service_eligibility_status).should eq(ada_service_eligibility_status)
      end

      it "redirects to the ada_service_eligibility_status" do
        ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
        put :update, {:id => ada_service_eligibility_status.to_param, :ada_service_eligibility_status => valid_attributes}
        response.should redirect_to(ada_service_eligibility_status)
      end
    end

    describe "with invalid params" do
      it "assigns the ada_service_eligibility_status as @ada_service_eligibility_status" do
        ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdaServiceEligibilityStatus.any_instance.stub(:save).and_return(false)
        put :update, {:id => ada_service_eligibility_status.to_param, :ada_service_eligibility_status => {:name => ''}}
        assigns(:ada_service_eligibility_status).should eq(ada_service_eligibility_status)
      end

      it "re-renders the 'edit' template" do
        ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdaServiceEligibilityStatus.any_instance.stub(:save).and_return(false)
        put :update, {:id => ada_service_eligibility_status.to_param, :ada_service_eligibility_status => {:name => ''}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ada_service_eligibility_status" do
      ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
      expect {
        delete :destroy, {:id => ada_service_eligibility_status.to_param}
      }.to change(AdaServiceEligibilityStatus, :count).by(-1)
    end

    it "redirects to the ada_service_eligibility_statuses list" do
      ada_service_eligibility_status = AdaServiceEligibilityStatus.create! valid_attributes
      delete :destroy, {:id => ada_service_eligibility_status.to_param}
      response.should redirect_to(ada_service_eligibility_statuses_url)
    end
  end

end
