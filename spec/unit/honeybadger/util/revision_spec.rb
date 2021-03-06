require 'honeybadger/util/revision'

describe Honeybadger::Util::Revision do
  after do
    ENV.delete('HEROKU_SLUG_COMMIT')
  end

  it "detects capistrano revision" do
    root = FIXTURES_PATH.to_s
    expect(Honeybadger::Util::Revision.detect(root)).to eq('rspec testing')
  end

  it "detects git revision" do
    expect(Honeybadger::Util::Revision.detect).to eq(`git rev-parse HEAD`.strip)
  end

  it "detects heroku revision" do
    ENV['HEROKU_SLUG_COMMIT'] = 'heroku revision'
    expect(Honeybadger::Util::Revision.detect).to eq('heroku revision')
  end
end
