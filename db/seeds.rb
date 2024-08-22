user = User.create!(email: "aaaa@aaa.com",
                    password:              "aaaaaa",
                    password_confirmation: "aaaaaa")


100.times do |n|
  title  = "example-#{n+1}"
  account = "aaaa@aaa.com"
  chars = ('a'..'z').to_a
  pass = 8.times.map{ chars.sample }.join
  url = "https://example-#{n+1}.com"
  memo = "example-#{n+1} Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore"
  user.passwords.create!(title: title,
                          account: account,
                          pass: pass,
                          url: url,
                          memo: memo
)
end
