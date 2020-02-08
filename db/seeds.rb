10.times do
  Product.create name: FFaker::Lorem.sentence, price: (10..20).to_a.sample * 1000
end
