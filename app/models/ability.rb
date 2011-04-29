class Ability
  include CanCan::Ability

  def initialize(user)

    #system tables
    can :read, Disposition
    can :read, Ethnicity
    can :read, EventType
    can :read, FundingSource
    can :read, Impairment
    can :read, ReferralType
    can :read, Route
    can :read, TripReason
    can :read, User

    if user.level >= 50
      ability = :manage
    else
      ability = :read
    end

    can ability, Assessment
    can ability, Case
    can ability, CaseRoute
    can ability, Customer
    can ability, CustomerImpairment
    can ability, Event
    can ability, Outcome

    #users can only read their own cases
    can :read, Contact
    can :manage, Contact, :user_id == user.id

    #and admins are admins
    if user.is_admin
      can :manage, :all
    end

  end
end