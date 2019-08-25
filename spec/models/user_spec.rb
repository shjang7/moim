# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
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

  context 'with valid attributes' do
    it 'is valid with correct informations' do
      jen = build(:user)
      expect(jen).to be_valid
    end

    it 'is same between full name and combining first and last name' do
      jen = build(:user)
      full_name = jen.first_name + ' ' + jen.last_name
      expect(full_name). to eq jen.name
    end
  end

  context 'with associated writing posts' do
    it 'should be destroyed along with user' do
      @jen = create(:user)
      @jen.writing_posts.create!(content: 'Lorem ipsum')
      expect do
        @jen.destroy
      end.to change(Post, :count).by(-1)
    end
  end
end
