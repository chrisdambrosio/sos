require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'should have a name' do
    FactoryGirl.build(:user).name.wont_be_nil
  end
end
