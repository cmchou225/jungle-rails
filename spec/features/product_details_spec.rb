require 'rails_helper'

RSpec.feature "User selects a product to show product details", type: :feature, js: true do
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

  scenario "User can see product details when selecting product" do
    visit root_path
    first('article.product').click_link('Details')
    sleep(5)
    save_screenshot 'product_details.png'
    expect(page).to have_css('article.product-detail')
  end
end
