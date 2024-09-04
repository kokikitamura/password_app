user = User.create!(email: "aaaa@aaa.com",
                    password: "aaaaaa",
                    password_confirmation: "aaaaaa")

user.categories.create!(name: "あああ")
user.categories.create!(name: "いいい")
user.categories.create!(name: "ううう")
user.categories.create!(name: "未分類")

100.times do |n|
  title  = "example-#{n+1}"
  account = "aaaa@aaa.com"
  chars = ('a'..'z').to_a
  pass = 8.times.map{ chars.sample }.join
  url = "https://example-#{n+1}.com"
  memo = "example-#{n+1} Lorem ipsum dolor sit amet, consectetur adipiscing elit"
  category_id = n % 3 + 1
  user.passwords.create!(title: title,
                          account: account,
                          pass: pass,
                          url: url,
                          memo: memo,
                          category_id: category_id
)
end
