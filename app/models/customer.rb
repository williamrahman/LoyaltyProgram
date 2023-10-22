class Customer < ApplicationRecord
  before_save :check_current_tier, :maintain_total_spent
  enum tier: [ :bronze, :silver, :gold ]
  has_many :orders

  def total_history_orders
    self.orders.sum(:total_order)
  end

  def current_tier_total_spent
    self.orders.where('created_at BETWEEN ? AND ?', DateTime.now.prev_year.beginning_of_year, DateTime.now).sum(:total_order)
  end

  def current_year_total_spent
    self.orders.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_year, DateTime.now).sum(:total_order)
  end

  def maintain_current_tier
    if self.silver?
      spent_to = self.current_year_total_spent > 100 ? 0 : 100 - self.current_year_total_spent
    elsif self.gold?
      spent_to = self.current_year_total_spent > 500 ? 0 : 500 - self.current_year_total_spent
    end
  end

  def upgrade_tier_spent
    if self.bronze?
      100 - current_tier_total_spent
    elsif self.silver?
      500 - current_tier_total_spent
    else
      0
    end
  end

  def next_tier
    if self.bronze?
      "SILVER"
    elsif self.silver?
      "GOLD"
    else
      self.tier.upcase
    end
  end

  def tier_before
    if self.gold?
      "SILVER"
    elsif self.silver?
      "BRONZE"
    else
      self.tier.upcase
    end
  end

  private
    def check_current_tier
      unless self.orders.size == 0
        if current_tier_total_spent < 100
          self.bronze! if self.tier != 'bronze'
        elsif current_tier_total_spent < 500
          self.silver! if self.tier != 'silver'
        elsif current_tier_total_spent >= 500
          self.gold! if self.tier != 'gold'
        end
      end
    end

    def maintain_total_spent
      unless self.orders.size == 0
        self.total_spent = current_tier_total_spent
        self.save! if self.total_spent != current_tier_total_spent
      end
    end
end
