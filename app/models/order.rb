class Order < ApplicationRecord
  after_save :check_current_tier, :maintain_total_spent
  belongs_to :customer

  private
    def check_current_tier
      if self.customer.current_tier_total_spent < 500 && self.customer.current_tier_total_spent >= 100
        self.customer.silver!
      elsif self.customer.current_tier_total_spent >= 500
        self.customer.gold!
      end
    end

    def maintain_total_spent
      self.customer.update!(total_spent: self.customer.current_tier_total_spent)
    end
end
