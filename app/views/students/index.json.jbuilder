json.array!(@students) do |student|
  json.extract! student, :id, :name, :netid, :isAdmin, :clubAffil, :password, :tiltAccNum, :pledges
  json.url student_url(student, format: :json)
end
