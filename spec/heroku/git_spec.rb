require "heroku/git"

describe Heroku::Git do
  it "determines an insecure 1.9 version is insecure" do
    expect(Heroku::Git.git_is_insecure('1.9.3')).to eq(true)
  end

  it "determines an secure 1.9 version is secure" do
    expect(Heroku::Git.git_is_insecure('1.9.5')).to eq(false)
  end
end
