class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :phone_number, type: String
  field :message, type: String
  field :user_id, type: BSON::ObjectId
  index({ user_id: 1 })

  validates :phone_number, presence: true
  validates :message, presence: true
  validates :user_id, presence: true


  def self.get_user_messages(id)
    where(user_id: id).order(created_at: :asc).map(&method(:message_hash))
  end

  def set_user_id(user)
    self.user_id = user.id
  end

  def self.message_hash(message)
    {
      id: message._id,
      created_at: message.created_at,
      phone_number: message.phone_number,
      message: message.message
    }
  end

  def save! # I wanted to put this on a mongo transaction but i was having issues
      super
      TwilioService.new.send_sms_message(self)
  end
end
