class SetUpPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin
        scope.all
      # else
        # redirect_to health_checks_path, status: :unprocessable_entity
      end
    end
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
