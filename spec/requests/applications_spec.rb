require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "ok"
    end
  end

  describe "authenticate_user! before_action" do
    it "redirects unauthenticated users to sign-in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows authenticated users" do
      user = create(:user)
      sign_in user
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "#skip_pundit?" do
    it "returns true for Devise controllers" do
      allow(controller).to receive(:devise_controller?).and_return(true)
      expect(controller.send(:skip_pundit?)).to be true
    end

    it "returns true for Pages controller path" do
      allow(controller).to receive(:devise_controller?).and_return(false)
      allow(controller).to receive(:params).and_return(ActionController::Parameters.new(controller: "pages"))
      expect(controller.send(:skip_pundit?)).to eq(0)
    end

    it "returns false for normal controllers" do
      allow(controller).to receive(:devise_controller?).and_return(false)
      allow(controller).to receive(:params).and_return(ActionController::Parameters.new(controller: "events"))
      expect(controller.send(:skip_pundit?)).to be_falsey
    end
  end
end
