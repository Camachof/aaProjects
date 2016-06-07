require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  context "GET #index" do
    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) {nil}
      end
      it "redirect_to the login page" do
        get :index, link: {}
        expect(response).to redirect_to(new_session_url)
      end
    end
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) {User.create(username: "Bob", password: "build that sucker")}
      end

      it "renders index view" do
        get :index, goal: {}
        expect(response).to render_template("index")
      end
    end

  end

  context "GET #show" do
    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) {nil}
      end
      it "redirect_to the sign up page" do
        get :show, id: 1
        expect(response).to redirect_to(new_session_url)
      end
    end
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) {User.create(username: "Bob", password: "build that sucker")}
      end

      it "renders show view" do
        get :show, id: 1
        expect(response).to render_template("show")
      end
    end

  end

  describe "POST #create" do
    context "with invalid params" do
      before do
        allow(controller).to receive(:current_user) {User.create(username: "Bob", password: "build that sucker")}
      end

      it "validates the presence of the goal's attributes" do
        post :create, goal: {title: "the title", body: ""}
        expect(response).to render_template "new"
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "renders goal show page" do
        post :create, goal: {title: "the title", body: "this is my bod", status: true, confidential: false}
        expect(response).to redirect_to goal_url(Goal.last)
      end
    end

  end
end

# post :create, user: {username: "jack_bruce", password: ""}
# expect(response).to render_template("new")
# expect(flash[:errors]).to be_present
