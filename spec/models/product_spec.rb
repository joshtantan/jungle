require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do
    before(:each) do
      @category = Category.create(:name => "Category Alpha")
      @category_id = @category.id

      @product = Product.new
    end

    context "with name, price, quantity, category set" do
      it "saves successfully with the correct data" do
        @product.name = "Product Alpha"
        @product.price = 2.25
        @product.quantity = 1
        @product.category_id = @category_id
        expect { @product.save! }.not_to raise_error

        expect(@product.id).to be_present
        expect(@product.created_at).to be_present
        expect(@product.updated_at).to be_present
        expect(@product.name).to include("Product Alpha")
        expect(@product.price_cents).to eq(225)
        expect(@product.quantity).to eq(1)
        expect(@product.category_id).to eq(@category_id)
      end
    end

    context "with price, quantity, category set but not name" do
      it "raises an error concerning missing name" do
        @product.price = 2.75
        @product.quantity = 2
        @product.category_id = @category_id
        expect { @product.save! }.to raise_error(/Name can't be blank/)
      end
    end

    context "with name, quantity, category set but not price" do
      it "raises an error concerning missing price" do
        @product.name = "Product Charlie"
        @product.quantity = 3
        @product.category_id = @category_id
        expect { @product.save! }.to raise_error(/Price cents is not a number, Price is not a number, Price can't be blank/)
      end
    end

    context "with name, price, category set but not quantity" do
      it "raises an error concerning missing quantity" do
        @product.name = "Product Delta"
        @product.price = 3.75
        @product.category_id = @category_id
        expect { @product.save! }.to raise_error(/Quantity can't be blank/)
      end
    end

    context "with name, price, quantity set but not category" do
      it "raises an error concerning missing category" do
        @product.name = "Product Delta"
        @product.price = 3.75
        @product.quantity = 5
        expect { @product.save! }.to raise_error(/Category can't be blank/)
      end
    end
  end
end
