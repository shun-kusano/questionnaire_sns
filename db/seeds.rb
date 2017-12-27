# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_num = 21
user_make_jikkou = 1
Answera.delete_all
Answerb.delete_all
Cmtnotification.delete_all
Ansnotification.delete_all
Comment.delete_all
Favorite.delete_all
Favnotification.delete_all
Questionnaire.delete_all
User.delete_all

if user_make_jikkou == 1
  user_num.times do |n|
      email = Faker::Internet.email
      name = Faker::Name.name
      password = 'password'
      create_daytime = Time.zone.now
      User.create!(email: email,
                  password: password,
                  password_confirmation: password,
                  name: name,
                  created_at: create_daytime,
                  updated_at: create_daytime,
                  avatar: open("#{Rails.root}/app/assets/images/s" + format("%03d", n+1) + ".png"),
                  uid: SecureRandom.uuid
                  #uid: n+2
                  )
  end
end

q_make_jikkou = 1
require 'csv'
if q_make_jikkou == 1
  Questionnaire.delete_all

  users = User.all
  user_num = users.count
  CSV.foreach('db/q_sample.csv') do |line|
    user_i =  Random.rand(0 .. (user_num-1))
    user = users[user_i]
    create_daytime = Time.zone.now
    Questionnaire.create!(body: line[0],
      optiona_body: line[1],
      optionb_body: line[2],
      user_id: user[:id],
      created_at: create_daytime,
      updated_at: create_daytime
    )
  end
end

a_make_jikkou = 1
if a_make_jikkou == 1
  Answera.delete_all
  Answerb.delete_all

  users = User.all
  user_num = users.count
  qs = Questionnaire.all
  q_num = qs.count
  users.each do |user|
    qs.each do |q|
      aorb = Random.rand(1 .. 2)
      create_daytime = Time.zone.now
      if aorb == 1
        Answera.create!(questionnaire_id: q.id,
          user_id: user.id,
          created_at: create_daytime,
          updated_at: create_daytime
        )
      else
        Answerb.create!(questionnaire_id: q.id,
          user_id: user.id,
          created_at: create_daytime,
          updated_at: create_daytime
        )
      end
    end
  end
end

comment_make_jikkou = 1
if comment_make_jikkou == 1
  Comment.delete_all
  users = User.all
  qs = Questionnaire.all
  q_num = qs.count

  users.each do |user|
    3.times do |n|
      qi = Random.rand(0 .. (q_num-1))
      content = Faker::Lorem.sentence(5)
      user.comments.create!(body: content,
        questionnaire_id: qs[qi][:id]
      )
    end
  end
end
