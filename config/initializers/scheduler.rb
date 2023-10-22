require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.cron('0 0 31 12 *') do
  Customer.all.each do |customer|
    next unless customer.maintain_current_tier != 0
    
    if customer.gold?
      customer.silver!
    elsif customer.silver?
      customer.gold!
    end
  end
end