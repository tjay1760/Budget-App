require 'rails_helper'

RSpec.describe 'categories index ' do
  before :each do
    @user = User.create(name: 'Tjay', email: 'mcjthiongo@gmail.com', password: '123456')
    @category = Category.create!(
      user: @user,
      name: 'food',
      icon: 'https://tse2.mm.bing.net/th?id=OIP.H-JJ97qWShgZbn6IzNEkpAHaHa&pid=Api&P=0&h=180'
    )
    @user.save
    login_as(@user, scope: :user)
  end

  it 'see the title in navbar ' do
    visit categories_path
    expect(page).to have_content('New category')
  end
  it 'see the category name ' do
    visit categories_path
    expect(page).to have_content(@category.name)
  end

  it 'see the icon' do
    visit categories_path
    expect(page).to have_selector("img[src='#{@category.icon}']")
  end

  it 'see the add category button ' do
    visit categories_path
    expect(page).to have_link('New category')
  end
end
