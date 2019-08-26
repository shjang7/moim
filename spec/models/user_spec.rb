# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attributes' do
    it 'is valid with correct informations' do
      jen = User.new(
        first_name: 'Jen',
        last_name: 'Barber',
        email: 'jen@example.com',
        password: 'foobar'
      )
      expect(jen).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'returns a user\'s full name as a string' do
      jen = build(:user)
      full_name = "#{jen.first_name} #{jen.last_name}"
      expect(jen.name). to eq full_name
    end
  end

  context 'with invalid attributes' do
    it 'is invalid without first name' do
      jen = build(:user, first_name: '')
      expect(jen).to_not be_valid
    end

    it 'is invalid without last name' do
      jen = build(:user, last_name: '')
      expect(jen).to_not be_valid
    end

    it 'is invalid without password' do
      jen = build(:user, password: '')
      expect(jen).to_not be_valid
    end

    it 'is invalid without an email' do
      jen = build(:user, email: '')
      expect(jen).to_not be_valid
    end

    it 'is invalid without password' do
      jen = build(:user, password: '')
      expect(jen).to_not be_valid
    end

    it 'is invalid with long size first name' do
      jen = build(:user, first_name: 'a' * 31)
      expect(jen).to_not be_valid
    end

    it 'is invalid with long size last name' do
      jen = build(:user, last_name: 'a' * 31)
      expect(jen).to_not be_valid
    end

    it 'is invalid with duplicate email' do
      mos = create(:user)
      jen = build(:user, email: mos.email)
      expect(jen).to_not be_valid
    end
  end

  context 'with associated writing posts' do
    let(:jen) { create(:user) }
    before do
      jen.writing_posts.create!(content: 'Lorem ipsum')
    end

    it 'should destroy post along with user' do
      expect do
        jen.destroy
      end.to change(Post, :count).by(-1)
    end

    it 'can have many posts' do
      expect do
        5.times do
          jen.writing_posts.create!(content: 'Lorem ipsum')
        end
      end.to change(jen.writing_posts, :count).by(5)
    end
  end
end
