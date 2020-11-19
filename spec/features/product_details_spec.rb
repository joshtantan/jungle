require "rails_helper"

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario "They first click a product from home page" do
    visit root_path
    product_name = find("article.product:first-child header").text

    within(find("article.product:first-child")) do
      click_on "Details"
    end

    expect(page).to have_text("Name")
    expect(page).to have_content(product_name)
  end
end
