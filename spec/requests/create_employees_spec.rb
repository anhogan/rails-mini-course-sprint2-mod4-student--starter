require 'rails_helper'

RSpec.describe "Create Employees", type: :request do
  describe "Create an Employee Request" do
    context "POST /employees with Valid Request" do
      it "Creates and Returns the Employee" do
        valid_params = { first_name: "New", last_name: "Employee" }

        post "/employees", params: valid_params
        response_body = JSON.parse(response.body).deep_symbolize_keys

        expect(response).status.to be :created
        expect(response_body).to include({
          first_name: "New",
          last_name: "Employee",
          rewards_balance: nil
        })
      end
    end

    context "POST /employees with Invalid Request" do
      it "Fails to Create and Returns Error" do
        invalid_params = { first_name: nil, last_name: nil }

        post "/employees", params: invalid_params

        expect(response).status.to be :unprocessable_entity
        expect(errors.count).to be > 0
      end
    end
  end
end
