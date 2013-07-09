class SmsReplyToken < ActiveRecord::Base
  belongs_to :alert
  belongs_to :user
  validates :user, presence: true
  before_create :before_create_hook
  attr_accessor :status_event

  def self.with_reply_code(code)
    if token = self.where(acknowledge_code: code.to_i).take
      token.status_event = :acknowledged
      token
    elsif token = self.where(resolve_code: code.to_i).take
      token.status_event = :resolved
      token
    else
      nil
    end
  end

  private

  def before_create_hook
    prefix = 0

    loop do
      tokens = SmsReplyToken.where(user: user, resolve_code: (prefix * 10) + 6)
      if tokens.count > 0 then prefix += 1 else break end
    end

    self.acknowledge_code = (prefix * 10) + 4
    self.resolve_code = (prefix * 10) + 6
  end
end
