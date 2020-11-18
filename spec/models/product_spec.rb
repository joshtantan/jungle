require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      @category = Category.create! name: "Category Alpha"
    end

    context "with name, price, quantity, category set" do
      it "raises no error and saves the correct data" do
        @product = @category.products.new({
          name: "Product Alpha",
          price: 2.25,
          quantity: 1,
        })

        expect(@product).to be_valid
      end
    end

    context "with price, quantity, category set but not name" do
      it "raises an error concerning missing name" do
        @product = @category.products.new({
          price: 2.75,
          quantity: 2,
        })

        expect { @product.save! }.to raise_error(/Name can't be blank/)
      end
    end

    context "with name, quantity, category set but not price" do
      it "raises an error concerning missing price" do
        @product = @category.products.new({
          name: "Product Charlie",
          quantity: 3,
        })

        expect { @product.save! }.to raise_error(/Price cents is not a number, Price is not a number, Price can't be blank/)
      end
    end

    context "with name, price, category set but not quantity" do
      it "raises an error concerning missing quantity" do
        @product = @category.products.new({
          name: "Product Delta",
          price: 3.75,
        })

        expect { @product.save! }.to raise_error(/Quantity can't be blank/)
      end
    end

    context "with name, price, quantity set but not category" do
      it "raises an error concerning missing category" do
        @product = Product.new({
          name: "Product Delta",
          price: 3.75,
          quantity: 5,
        })

        expect { @product.save! }.to raise_error(/Category can't be blank/)
      end
    end
  end
end
