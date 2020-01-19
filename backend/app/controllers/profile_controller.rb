class ProfileController < ApplicationController
  layout 'standard'
  skip_before_action :verify_authenticity_token
  def create
    co_application_credit_rating = CreditRating.where(name: params[:co_application_credit_rating]).first
    if !co_application_credit_rating.blank?
      co_application_credit_rating = co_application_credit_rating.id
    end

    @profile = Profile.create!(
      age: params[:age],
      current_residence_years: params[:current_residence_years],
      is_married: params[:is_married],
      number_of_dependants: params[:number_of_dependants],
      graduated: params[:graduated],
      self_employed: params[:self_employed],
      years_of_job_stability: params[:years_of_job_stability],
      years_of_salary: params[:years_of_salary],
      credit_rating: CreditRating.where(name: params[:credit_rating]).first.id,
      co_application_age: params[:co_application_age],
      co_application_years_of_job_stability: params[:co_application_years_of_job_stability],
      co_application_yearly_salary: params[:co_application_yearly_salary],
      co_application_credit_rating: co_application_credit_rating,
      loan_term_in_years: params[:loan_term_in_years],
      loan_amount: params[:loan_amount],
      property_total_cost: params[:property_total_cost],
      area_classification: AreaClassification.where(name: params[:area_classification]).first.id,
      approved: false
    )

    @profile.approved = validate(@profile)
    @profile.save

    render :json => @profile
  end

  def list
    @profile = Profile.all
    render :json => @profile
  end

  def show
    @profile = Profile.find(params[:id])
    render :json => @profile
  end

  def validate(profile)
    profile_credit = CreditRating.find(profile.credit_rating)
    if !profile_credit.blank?
      profile_credit = profile_credit.name
    end

    if profile.co_application_credit_rating != nil
      co_credit = CreditRating.find(profile.co_application_credit_rating)
      if !co_credit.blank?
        co_credit = co_credit.name
      end
    else
      co_credit = nil
    end

    area_classification = AreaClassification.find(profile.area_classification)
    if !area_classification.blank?
      area_classification = area_classification.name
    end

    path = Rails.root + "app/helpers/CSI_2.model"
    booster = Xgb::Booster.new(model_file: path.to_s)

    model = Xgb::DMatrix.new([
      [
        profile.age,
        profile.current_residence_years,
        ActiveRecord::Type::Integer.new.cast(profile.is_married),
        profile.number_of_dependants,
        ActiveRecord::Type::Integer.new.cast(profile.graduated),
        ActiveRecord::Type::Integer.new.cast(profile.self_employed),
        profile.years_of_job_stability,
        profile.years_of_salary,
        ActiveRecord::Type::Integer.new.cast("AA" == profile_credit), # AA
        ActiveRecord::Type::Integer.new.cast("AAA" == profile_credit), # AAA
        ActiveRecord::Type::Integer.new.cast("B" == profile_credit), # B
        ActiveRecord::Type::Integer.new.cast("C" == profile_credit), # C
        profile.co_application_age,
        profile.co_application_years_of_job_stability,
        profile.co_application_yearly_salary,
        ActiveRecord::Type::Integer.new.cast("AA" == co_credit), # AA
        ActiveRecord::Type::Integer.new.cast("AAA" == co_credit), # AAA
        ActiveRecord::Type::Integer.new.cast("B" == co_credit), # B
        ActiveRecord::Type::Integer.new.cast("C" == co_credit), # C
        ActiveRecord::Type::Integer.new.cast(nil == co_credit), # null
        profile.loan_term_in_years,
        profile.loan_amount,
        profile.property_total_cost,
        ActiveRecord::Type::Integer.new.cast("CLASS_B" == area_classification),
        ActiveRecord::Type::Integer.new.cast("CLASS_C" == area_classification)
      ]
    ])

    respond = booster.predict(model)
    return respond => 0.5
  end
end