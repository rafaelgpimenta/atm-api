require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
RSpec.describe "/auths", type: :request do
  describe "POST #sign_up" do
    let(:valid_params) do
      { cpf: '123', password: '123', password_confirmation: '123' }
    end

    let(:invalid_params) do
      { cpf: '123', password: '123', password_confirmation: '12' }
    end

    context "with valid parameters" do
      it "create new Customer and Account" do
        expect {
          post sign_up_auth_url, params: valid_params, as: :json
        }.to change(Customer, :count).by(1).and change(Account, :count).by(1)
      end

      it "renders a JSON response with auth token" do
        post sign_up_auth_url, params: valid_params, as: :json
        body = JSON.parse(response.body).with_indifferent_access

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body).to include(:access)
      end
    end

    context "with invalid parameters" do
      it "not create Customer and Account" do
        expect {
          post sign_up_auth_url, params: invalid_params, as: :json
        }.to change(Customer, :count).by(0).and change(Account, :count).by(0)
      end

      it "renders a JSON response with errors" do
        post sign_up_auth_url, params: invalid_params, as: :json
        body = JSON.parse(response.body).with_indifferent_access

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body).to include(error: "Password confirmation doesn't match Password")
      end
    end
  end

  describe "POST #sign_in" do
    let!(:customer) { create(:customer) }
    let(:valid_params) do
      { cpf: '12345', password: 'senha' }
    end
    let(:invalid_params) do
      { cpf: '1234', password: 'senha' }
    end

    context "with valid parameters" do
      it "renders a JSON response with auth token" do
        post sign_in_auth_url, params: valid_params, as: :json
        body = JSON.parse(response.body).with_indifferent_access

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body).to include(:access)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors" do
        post sign_in_auth_url, params: invalid_params, as: :json
        body = JSON.parse(response.body).with_indifferent_access

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body).to include(error: "Customer not found")
      end
    end
  end

  describe "POST #sign_out" do
    let!(:customer) { create(:customer) }
    let(:tokens) { login(customer) }

    it "renders a successful response" do
      post sign_out_auth_url, as: :json, headers: auth_header(tokens[:access])

      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(JSON.parse(response.body)).to eq("ok")
    end

    it "renders an unauthorized response" do
      invalid_key = tokens[:access][0...-1]
      post sign_out_auth_url, as: :json, headers: auth_header(invalid_key)
      body = JSON.parse(response.body).with_indifferent_access

      expect(response).to have_http_status(:unauthorized)
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response.body).to eq("{\"error\":\"Not authorized\"}")
    end
  end

  describe "POST #refresh" do
    let!(:customer) { create(:customer) }
    let!(:tokens) { login(customer) }

    context 'when token expired and able to refresh' do
      before { travel 2.hours }
      after { travel_back }

      it "renders a successful response" do
        post refresh_auth_url, as: :json, headers: auth_header(tokens[:access])
        body = JSON.parse(response.body).with_indifferent_access

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(body).to include(:access)
      end
    end

    context 'when token expired and not able to refresh' do
      before { travel 2.weeks }
      after { travel_back }

      it "renders an unauthorized response" do
        post refresh_auth_url, as: :json, headers: auth_header(tokens[:access])

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq("{\"error\":\"Not authorized\"}")
      end
    end

    context 'when token not expired' do
      it "renders an unauthorized response" do
        post refresh_auth_url, as: :json, headers: auth_header(tokens[:access])

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq("{\"error\":\"Not authorized\"}")
      end
    end
  end
end
