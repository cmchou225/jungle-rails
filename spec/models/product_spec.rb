require 'rails_helper'
    # t.string   "name"
    # t.text     "description"
    # t.string   "image"
    # t.integer  "price_cents"
    # t.integer  "quantity"
    # t.integer  "category_id"


RSpec.describe Product, type: :model do
  before :each do
    @category = Category.new
    @product = Product.new(name: 'a', description: 'test', image: 'img', price: 1.11, quantity: 1, category: @category)
  end
  describe 'Validations' do
    it 'should create new product with valid inputs' do
      expect(@product).to be_valid
    end
    it 'should not create product with no name' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors[:name]).to include("can't be blank")
    end
    it 'should not create product with no price' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors[:price]).to include("can't be blank")
    end
    it 'should not create product with no quantity' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors[:quantity]).to include("can't be blank")
    end
    it 'should not create product with no category' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors[:category]).to include("can't be blank")
    end
  end                       
end
