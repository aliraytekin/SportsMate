class CommentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # def resolve
    #   scope.all
    # end
  end

  def create?
    true
  end
end
