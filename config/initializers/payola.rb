
Payola.configure do |config|
  # Example subscription:
  #
  # config.subscribe 'payola.package.sale.finished' do |sale|
  #   EmailSender.send_an_email(sale.email)
  # end
  #
  # In addition to any event that Stripe sends, you can subscribe
  # to the following special payola events:
  #
  #  - payola.<sellable class>.sale.finished
  #  - payola.<sellable class>.sale.refunded
  #  - payola.<sellable class>.sale.failed
  #
  # These events consume a Payola::Sale, not a Stripe::Event
  #
  # Example charge verifier:
  #
  # config.charge_verifier = lambda do |sale|
  #   raise "Nope!" if sale.email.includes?('yahoo.com')
  # end

  # Keep this subscription unless you want to disable refund handling
  config.subscribe 'charge.refunded' do |event|
    sale = Payola::Sale.find_by(stripe_id: event.data.object.id)
    sale.refund!
    end
    Payola.configure do |payola|

      payola.secret_key = 'sk_test_2xu5LFi0pdbU2ZymgNtB26Jt'
      payola.publishable_key = 'pk_test_zKc6jlLbPrs4AdST6ZD0qpEX'

   payola.default_currency = 'usd'

  payola.subscribe 'payola.credit_plan.sale.finished' do |sale|
  end

  payola.subscribe 'payola.book.sale.failed' do |sale|
    SaleMailer.admin_failed(sale.guid).deliver
  end

  payola.subscribe 'payola.book.sale.refunded' do |sale|
    SaleMailer.admin_refunded(sale.guid).deliver
  end


  end
end
