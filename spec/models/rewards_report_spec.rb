require 'rails_helper'

RSpec.describe RewardsReport do
  describe "Rewards Report Notify" do
    let(:rewardOne) { double("Reward", cost: 30, inventory: 5, deactivated_at: nil, name: "First", pucharse_count: 30) }
    let(:rewardTwo) { double("Reward", cost: 20, inventory: 5, deactivated_at: nil, name: "Second", pucharse_count: 70) }
    let(:rewardThree) { double("Reward", cost: 10, inventory: 5, deactivated_at: nil, name: "Third", pucharse_count: 100) }

    context "#total_purchases" do
      it "Should Send Email with Purchase Report" do
        rewards = [rewardOne, rewardTwo, rewardThree]
        total = rewards.total_purchases

        expect(NotificationService).to receive(total).with(200)
      end
    end
  end
end
