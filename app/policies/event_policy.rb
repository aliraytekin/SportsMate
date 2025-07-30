class EventPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def cancel?
    record.user == user
  end

  def payment?
    user != record.user || record.participations.exists?(user: user, payment_status: :pending)
  end

  def confirmation?
    record.participations.exists?(user: user, payment_status: :paid) || user == record.user
  end


  def calendar?
    user != record.user && record.participations.exists?(user: user)
  end
end
