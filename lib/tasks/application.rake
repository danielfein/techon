namespace :application do
   # to run:
   # rake application:seed
   task :seed => :environment do
      CreditPlan.create(name: 'One Hundred', permalink: 'one-hundred', price: 1000, award_credits: 100)
      CreditPlan.create(name: 'Five Hundred', permalink: 'five-hundred', price: 3000, award_credits: 500)
   end
end
