class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def read_all?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end
end
