require 'rails_helper'

RSpec.feature "User adds products to carts", type: :feature, js: true do
  before :each do
    @category = Category.create(name: 'Apparel')

    10.times do |n|
      @category.products.create(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'User clicks add button on product and cart count updates' do
    visit root_path
    first('article.product').click_link('Add')
    sleep(4)
    save_screenshot 'cart_count.png'

    expect(page).to have_content("My Cart (1)")
  end
end
