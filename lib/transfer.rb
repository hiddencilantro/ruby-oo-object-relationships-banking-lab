class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && sender.balance >= amount && valid?
      sender.withdraw(amount)
      receiver.deposit(amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && receiver.balance >= amount && valid?
      receiver.withdraw(amount)
      sender.deposit(amount)
      self.status = "reversed"
    end
  end
end
