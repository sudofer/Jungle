require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validations' do
    it 'will save if all fields are present' do
      @test_category = Category.create({name: 'test'})
      @test_product = @test_category.products.create({name: 'boot', price: 15, quantity: 100})
      expect(@test_product).to be_valid
    end
    it 'will not save if category is nil' do
      @test_category = Category.create({name: 'test'})
      @test_product = Product.new({name: 'boot', price: 15, quantity: 100, category: nil})
      expect(@test_product).to_not be_valid
    end
    it 'will not save if name is nil' do
      @test_category = Category.create({name: 'test'})
      @test_product = @test_category.products.create({name: nil, price: 15, quantity: 100})
      expect(@test_product).to_not be_valid
    end
    it 'will not save if price is nil' do
      @test_category = Category.create({name: 'test'})
      @test_product = @test_category.products.create({name: 'boot', price: nil, quantity: 100})
      expect(@test_product).to_not be_valid
    end
    it 'will not save if quantity is nil' do
      @test_category = Category.create({name: 'test'})
      @test_product = @test_category.products.create({name: 'boot', price: 15, quantity: nil})
      expect(@test_product).to_not be_valid
    end
  end
end