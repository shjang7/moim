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
      jen = create(:user)
      expect(jen).to be_valid
    end
  end

  context 'for first name and last name' do
    it 'is same name after combining' do
      jen = create(:user)
      combined_name = jen.first_name + ' ' + jen.last_name
      expect(combined_name). to eq jen.name
    end
  end
end
