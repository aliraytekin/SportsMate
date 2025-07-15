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

  def destroy?
    record.user == user
  end
end
