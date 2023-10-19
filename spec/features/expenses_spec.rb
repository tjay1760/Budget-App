require 'rails_helper'

RSpec.describe 'categories index' do
  before :each do
    @user = User.create(name: 'Tjay', email: 'mcjthiongo@gmail.com', password: '123456')
    @category = Category.create(
      user: @user,
      name: 'food',
      icon: 'https://tse2.mm.bing.net/th?id=OIP.H-JJ97qWShgZbn6IzNEkpAHaHa&pid=Api&P=0&h=180'
    )

    @expenses = @category.expenses.create([
      { name: 'burger', amount: 12, user: @user },
      { name: 'chips', amount: 5, user: @user }
    ])

    @user.save
    login_as(@user, scope: :user)
  end

  it 'see the category name' do
    visit category_expenses_path(@category.id)
    expect(page).to have_content(@expenses.first.name)
    expect(page).to have_content(@expenses.second.name)
  end

   
  it 'displays the price of each expense on the category page' do
    visit category_expenses_path(@category)
    @expenses.each do |expense|
      expect(page).to have_content(expense.amount.to_i)
    end
  end
  

  it 'see the Amount text' do
    visit category_expenses_path(@category.id)
    expect(page).to have_content('amount:')
  end
  it 'displays the expense names on the category page' do
    visit category_expenses_path(@category)
    expect(page).to have_content(@expenses[0].name)
    expect(page).to have_content(@expenses[1].name)
  end
end
