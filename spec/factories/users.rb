FactoryGirl.define do
  factory :user do
    name "User 1"
		email "user1@email.com"
		password "pass"
		password_confirmation "pass"
		admin false
  end

end
