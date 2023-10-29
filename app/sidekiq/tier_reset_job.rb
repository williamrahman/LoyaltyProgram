class TierResetJob
  include Sidekiq::Job

  def perform()
    Customer.all.each do |customer|
      next unless customer.maintain_current_tier != 0
      
      if customer.gold?
        customer.silver!
      elsif customer.silver?
        customer.gold!
      end
    end
  end
end
