User.create! name: "Admin", role: "admin", email: "admin@gmail.com",
  password: "12345678", password_confirmation: "12345678"

gender = ["male", "female"]
badge = ["general", "business", "special"]
birthday1 = Date.today - 22.years
birthday2 = Date.today - 32.years
birthday3 = Date.today - 42.years

puts "create member"
(1..50).each do |n|
  User.create! name: "Member #{n}", role: "member", email: "member#{n}@gmail.com",
  password: "12345678", password_confirmation: "12345678",
  passport: "ABCD1234", credit_card: "ABCD1234",
  gender: gender.sample, birthday: birthday1, badge: badge.sample
end

(51..100).each do |n|
  User.create! name: "Member #{n}", role: "member", email: "member#{n}@gmail.com",
  password: "12345678", password_confirmation: "12345678",
  passport: "ABCD1234", credit_card: "ABCD1234",
  gender: gender.sample, birthday: birthday2, badge: badge.sample
end

(101..150).each do |n|
  User.create! name: "Member #{n}", role: "member", email: "member#{n}@gmail.com",
  password: "12345678", password_confirmation: "12345678",
  passport: "ABCD1234", credit_card: "ABCD1234",
  gender: gender.sample, birthday: birthday3, badge: badge.sample
end

puts "create place"
Place.create! city: "Hà Nội", country: "Việt Nam"
Place.create! city: "Hải Phòng", country: "Việt Nam"
Place.create! city: "TP HCM", country: "Việt Nam"
Place.create! city: "Cần Thơ", country: "Việt Nam"
Place.create! city: "Đà Nẵng", country: "Việt Nam"
Place.create! city: "Singapore", country: "Singapore"
Place.create! city: "Bangkok", country: "Thái Lan"
Place.create! city: "New York", country: "Mỹ"
Place.create! city: "London", country: "Anh"
Place.create! city: "California", country: "Mỹ"

puts "create company"
Company.create! name: "Vietnam Airline"
Company.create! name: "American Airline"
Company.create! name: "Jetstar"
Company.create! name: "Vietjet Air"
Company.create! name: "VASCO"

puts "create plane"
(111..120).each do |n|
  Plane.create! name: "Vietnam Airline #{n}", code: "VNA #{n}", company_id: 1, status: 1
end

(161..170).each do |n|
  Plane.create! name: "American Airline #{n}", code: "AA #{n}", company_id: 2, status: 1
end

(771..780).each do |n|
  Plane.create! name: "Jetstar #{n}", code: "JPA #{n}", company_id: 3, status: 1
end

(611..620).each do |n|
  Plane.create! name: "Vietjet Air #{n}", code: "VJA #{n}", company_id: 4, status: 1
end

puts "create flight"
start_time = Date.today() + 22.days
end_time = start_time + 2.days
Plane.all.each do |plane|
  Flight.create! code: rand(125..330), start_time: start_time, end_time: end_time,
    plane_id: plane.id, start_place_id: Place.all.sample.id,
    end_place_id: Place.all.sample.id, cooldown_date: rand(5..30)
end
