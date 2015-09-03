namespace :application do
   # to run:
   # rake application:seed
   task :seed => :environment do
      CreditPlan.create(name: 'One Hundred', permalink: 'one-hundred', price: 1000, award_credits: 100)
      CreditPlan.create(name: 'Five Hundred', permalink: 'five-hundred', price: 3000, award_credits: 500)
      Product.create(name: 'FC Barcelona', price: '4', provider: 'facebook', url: 'https://www.facebook.com/fcbarcelona', pretty_url: 'https://www.facebook.com/fcbarcelona', owner_uid: 1, provider_id: 197394889304, cover_photo: 'https://scontent.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/s720x720/11899941_10153767740279305_5587917880635699275_n.jpg?oh=858b3e2be76a9684ea741c3742b41652&oe=5661DFA3', profile_pic: 'https://scontent.xx.fbcdn.net/hprofile-xaf1/v/t1.0-1/p50x50/13029_10153266581599305_3902534924989850048_n.jpg?oh=5a57e2793de361435006af032d4b21bb&oe=567DF204')
      Product.create(name: 'Cristiano Ronaldo', price: '4', provider: 'facebook', url: 'https://www.facebook.com/Cristiano', pretty_url: 'https://www.facebook.com/Cristiano', owner_uid: 2, provider_id: 81221197163, cover_photo: 'https://scontent.xx.fbcdn.net/hphotos-xaf1/t31.0-8/q82/s720x720/10348933_10153246586042164_3684248805740416253_o.jpg', profile_pic: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfa1/v/t1.0-1/p50x50/10374989_10153246585102164_6481251831200301634_n.jpg?oh=ab94a88008e4d475f818168274a01d66&oe=5680279A&__gda__=1449548819_525657a49f799740fbbd1fe304a3a75c')
      Product.create(name: 'Lionel Messi', price: '4', provider: 'facebook', url: 'https://www.facebook.com/LeoMessi', pretty_url: 'https://www.facebook.com/LeoMessi', owner_uid: 1, provider_id: 176063032413299, cover_photo: 'https://scontent.xx.fbcdn.net/hphotos-xtp1/v/t1.0-9/s720x720/11863386_1079035765449350_8628655056381141485_n.jpg?oh=ded97ff07ca103b4ec1c3d8cb9754d8d&oe=566653B2', profile_pic: 'https://scontent.xx.fbcdn.net/hprofile-xfp1/v/t1.0-1/p50x50/10985040_1031264183559842_1554156562033409403_n.jpg?oh=5459744af27aa8ec0ecb6cf782f75537&oe=565D39C9')
      Product.create(name: 'Neymar', price: '4', provider: 'facebook', url: 'https://www.facebook.com/neymarjr', pretty_url: 'https://www.facebook.com/neymarjr', owner_uid: 2, provider_id: 148456285190063,  cover_photo: 'https://scontent.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/s720x720/11781867_935886343113716_6135255361852636704_n.jpg?oh=e794740b056723555ab018387c32e658&oe=565D5582', profile_pic: 'https://scontent.xx.fbcdn.net/hprofile-xtp1/v/t1.0-1/p50x50/11988299_936514546384229_5700239197321811824_n.jpg?oh=f7928bf012ec45106b73dfc2cf898a90&oe=56791ABD')

   end
end
