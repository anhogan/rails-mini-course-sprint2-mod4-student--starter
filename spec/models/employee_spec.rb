require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "Validations" do
    it "Validates Employee with All Attributes" do
      employee = Employee.new(first_name: "New", last_name: "Employee", rewards_balance: nil)

      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be true
      expect(errors.count).to be 0
    end

    it "Throws an Error if no First Name" do
      employee = Employee.new(first_name: nil, last_name: "Employee", rewards_balance: nil)

      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be false
      expect(errors.count).to be > 0
    end

    it "Throws an Error if no Last Name" do
      employee = Employee.new(first_name: "New", last_name: nil, rewards_balance: nil)

      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be false
      expect(errors.count).to be > 0
    end
  end

  describe "Attributes" do
    it "Has Expected Attributes" do
      employee = Employee.new(first_name: "New", last_name: "Employee", rewards_balance: nil).attribute_names

      expect(employee).to contain_exactly("id", "first_name", "last_name", "rewards_balance", "created_at", "updated_at")
    end
  end

  describe "Scopes" do
    before do
      Employee.create!(
        { first_name: "First", last_name: "Employee", rewards_balance: 0 },
        { first_name: "Second", last_name: "Employee", rewards_balance: 10 },
        { first_name: "Third", last_name: "Employee", rewards_balance: -5 },
        { first_name: "Fourth", last_name: "Employee", rewards_balance: nil },
      )
    end

    it "Returns zero_balance Scope Results" do
      results = Employee.zero_balance

      expect(results.count).to eq 2
      expect(results[1].rewards_balance).to eq 10
      expect(results.last.rewards_balance).to be_nil
    end
  end

  describe "Instance Methods" do
    it "Validates full_name Method" do
      employee = Employee.new(first_name: "New", last_name: "Employee", rewards_balance: nil)
      result = employee.full_name

      expect(result).to eq "New Employee"
    end

    it "Validates can_afford? Method" do
      employee = Employee.new(first_name: "New", last_name: "Employee", rewards_balance: 10)
      
      if rewards_cost = 25
        unaffordable = employee.can_afford?(rewards_cost)

        expect(unaffordable).to be false
      elsif rewards_cost = 5
        affordable = employee.can_afford?(rewards_cost)

        expect(affordable).to be true
      end
    end
  end
end
