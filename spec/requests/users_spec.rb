require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }

    context "success" do
      before { get users_path }

      it "status of response is success" do
        expect(response).to have_http_status(:ok)
      end

      it "assigns @users" do
        expect(assigns[:users]).to match_array([user_1, user_2])
      end
    end
  end

  describe "GET /new" do
    before { get new_user_path }

    it "status of response is success" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns @user" do
      expect(assigns[:user]).not_to(be_nil)
    end
  end

  describe "POST /create" do
    context "success" do
      let(:user_attributes) do
        {
          user: {
            name: "John Doe",
            email: "john@doe.com",
          },
        }
      end

      before do
        post users_path, params: user_attributes
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to show" do
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context "failure" do
      let(:invalid_attributes) do
        { user: { name: "", email: "" } }
      end

      before do
        post users_path, params: invalid_attributes
      end

      it "returns status code unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders action" do
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }

    before do
      get edit_user_path(user)
    end

    it "status of response is success" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns user" do
      expect(assigns[:user]).to eq(user)
    end
  end


  describe "PATCH /update" do
    context "success" do
      let(:user) { create(:user) }

      before do
        patch user_path(user), params: { user: { name: "John Doe updated" } }
      end

      it "returns status code 302" do
        expect(response).to(have_http_status(:found))
      end

      it "assigns @user" do
        expect(assigns[:user].name).to eq("John Doe updated")
      end

      it "redirects to show" do
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "failure" do
      let(:user) { create(:user) }

      before do
        patch user_path(user.id), params: { user: { name: "" } }
      end

      it "render edit" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { create(:user) }

    before do
      delete user_path(user)
    end

    it "deletes user" do
      expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
