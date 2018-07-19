class Transfer
  attr_reader :receiver, :sender, :status, :amount

  def initialize(sender, receiver, amount)
    @receiver = receiver
    @sender = sender
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.status = "open"
      if status != "complete" && self.sender.balance >= amount
        self.sender.balance -= amount
        self.receiver.balance += amount
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    else
      @status = "rejected"
    end
  end

  def reverse_transfer
    if status === "complete"
      @status = "reversed"
      self.sender.balance += amount
      self.receiver.balance -= amount
    end
  end
end
