require 'rails_helper'

RSpec.describe RewardsReport do
  describe "Rewards Report Notify" do
    let(:rewardOne) { double("Reward", cost: 30, inventory: 5, deactivated_at: nil, name: "First", pucharse_count: 30) }
    let(:rewardTwo) { double("Reward", cost: 20, inventory: 5, deactivated_at: nil, name: "Second", pucharse_count: 70) }
    let(:rewardThree) { double("Reward", cost: 10, inventory: 5, deactivated_at: nil, name: "Third", pucharse_count: 100) }

    it "Should Send Email with Purchase Report" do
      rewards = [rewardOne.pucharse_count, rewardTwo.pucharse_count, rewardThree.pucharse_count]
      total = rewards.reduce(0) { |total, reward| total + reward }

      expect(total).to eq 200
      expect(:notify).to receive(total)
    end
  end
end
