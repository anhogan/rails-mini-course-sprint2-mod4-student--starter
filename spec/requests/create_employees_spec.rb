require 'rails_helper'

RSpec.describe "Create Employees", type: :request do
  describe "Create an Employee Request" do
    context "POST /employees with Valid Request" do
      it "Creates and Returns the Employee" do
        valid_params = { employee: {first_name: "New", last_name: "Employee", rewards_balance: nil} }
        puts(params: valid_params)

        post "/employees", params: valid_params
        response_body = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(201)
        expect(response_body).to include({
          first_name: "New",
          last_name: "Employee",
          rewards_balance: nil
        })
      end
    end

    context "POST /employees with Invalid Request" do
      it "Fails to Create and Returns Error" do
        invalid_params = { employee: {first_name: nil, last_name: nil, rewards_balance: nil} }
        puts(params: invalid_params)

        post "/employees", params: invalid_params

        expect(response).to have_http_status(422)
      end
    end
  end
end
