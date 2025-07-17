class PaymentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # def resolve
    #   scope.all
    # end
  end

  def payment?
    record.users.include?(user)
  end

  def success?
    payment?
  end

  def confirmation?
    payment?
  end
end
