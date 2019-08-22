require 'rails_helper'

RSpec.describe User, type: :model do
  let(:mos) { create(:user) }

  context 'with valid attributes' do
    it 'is valid with an email and password' do
      expect(mos).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'is invalid without an email' do
      mos.email=''
      mos.valid?
      # mos2 = build(:user, email: '')
      expect(mos.errors[:email]).to include("can't be blank")
    end
    it 'is invalid without password' do
      mos.password=''
      mos.valid?
      expect(mos.errors[:password]).to include("can't be blank")
    end

    it 'is invalid with duplicate email' do
      jen = build(:user, email: mos.email)
      expect(jen).to_not be_valid
    end
  end
end
