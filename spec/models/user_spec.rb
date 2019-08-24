# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:jen) { create(:user) }

  context 'with invalid attributes' do
    it 'is invalid without first name' do
      jen.first_name = ''
      jen.valid?
      expect(jen.errors[:first_name]).to include("can't be blank")
    end

    it 'is invalid without last name' do
      jen.last_name = ''
      jen.valid?
      expect(jen.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid without password' do
      jen.last_name = ''
      jen.valid?
      expect(jen.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      jen.email = ''
      jen.valid?
      expect(jen.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without password' do
      jen.password = ''
      jen.valid?
      expect(jen.errors[:password]).to include("can't be blank")
    end

    it 'is invalid with long size first name' do
      mos = build(:user, first_name: 'a' * 31)
      expect(mos).to_not be_valid
    end

    it 'is invalid with long size last name' do
      mos = build(:user, last_name: 'a' * 31)
      expect(mos).to_not be_valid
    end

    it 'is invalid with duplicate email' do
      mos = build(:user, email: jen.email)
      expect(mos).to_not be_valid
    end
  end

  context 'with valid attributes' do
    it 'is valid with correct informations' do
      expect(jen).to be_valid
    end
  end

  context 'for first name and last name' do
    it 'is same name after combining' do
      combined_name = jen.first_name + ' ' + jen.last_name
      expect(combined_name). to eq jen.name
    end
  end
end
