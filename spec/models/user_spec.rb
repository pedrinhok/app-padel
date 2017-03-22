require 'rails_helper'

RSpec.describe User, type: :model do

	it { should validate_presence_of(:name) }

	it { should validate_length_of(:name).is_at_least(3) }

	it { should validate_uniqueness_of(:name) }

	it { should validate_presence_of(:email) }

	it { should_not allow_value("a", "a@", "a@b", "a@b.").for(:email) }
	it { should allow_value("a@b.c").for(:email) }

	it { should validate_uniqueness_of(:email) }

	it { should validate_confirmation_of(:password) }

	it { should have_secure_password }

end
