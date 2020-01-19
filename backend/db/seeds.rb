require 'csv'

# Credit Ratings
puts "Seed Credit Ratings"
credit_1 = CreditRating.where(name: "AAA").first
if credit_1.blank?
  credit_1 = CreditRating.create!(
    number: 1,
    name: "AAA"
  )
end
credit_2 = CreditRating.where(name: "AA").first
if credit_2.blank?
  credit_2 = CreditRating.create!(
    number: 2,
    name: "AA"
  )
end

credit_3 = CreditRating.where(name: "A").first
if credit_3.blank?
  credit_3 = CreditRating.create!(
    number: 3,
    name: "A"
  )
end

credit_4 = CreditRating.where(name: "B").first
if credit_4.blank?
  credit_4 = CreditRating.create!(
    number: 4,
    name: "B"
  )
end

credit_5 = CreditRating.where(name: "C").first
if credit_5.blank?
  credit_5 = CreditRating.create!(
    number: 5,
    name: "C"
  )
end

# Area Clasification
puts "Seed Area Clasification"
area_1 = AreaClassification.where(name: "CLASS_A").first
if area_1.blank?
  area_1 = AreaClassification.create!(
    number: 1,
    name: "CLASS_A"
  )
end

area_2 = AreaClassification.where(name: "CLASS_B").first
if area_2.blank?
  area_2 = AreaClassification.create!(
    number: 2,
    name: "CLASS_B"
  )
end

area_3 = AreaClassification.where(name: "CLASS_C").first
if area_3.blank?
  area_3 = AreaClassification.create!(
    number: 3,
    name: "CLASS_C"
  )
end

# Profile
puts "Seed Profile"
Profile.delete_all
csv_text = File.read(Rails.root.join('db/TrainingData.csv'))
csv = CSV.parse(csv_text, :headers => false)
csv.each_with_index do |row, index|
  co_application_credit_rating = CreditRating.where(name: row[13]).first
  if !co_application_credit_rating.blank?
    co_application_credit_rating = co_application_credit_rating.id
  end

  profile = Profile.create!(
    age: row[1],
    current_residence_years: row[2],
    is_married: row[3],
    number_of_dependants: row[4],
    graduated: row[5],
    self_employed: row[6],
    years_of_job_stability: row[7],
    years_of_salary: row[8],
    credit_rating: CreditRating.where(name: row[9]).first.id,
    co_application_age: row[10],
    co_application_years_of_job_stability: row[11],
    co_application_yearly_salary: row[12],
    co_application_credit_rating: co_application_credit_rating,
    loan_term_in_years: row[14],
    loan_amount: row[15],
    property_total_cost: row[16],
    area_classification: AreaClassification.where(name: row[17]).first.id,
    approved: row[18]
  )

  puts profile

  # Stop after 10
  if index > 10
    return
  end
end
