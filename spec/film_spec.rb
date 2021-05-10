require 'rspec'
require_relative '../lib/film.rb'

describe Film do

  it 'should do ok for initialize' do
    test_film = Film.new('Test name', 'Test producer', '2010')

    expect(test_film.name).to eq 'Test name'
    expect(test_film.producer).to eq 'Test producer'
    expect(test_film.year_of_issue).to eq '2010'
  end

  before(:all) do
    test_file_path = "spec/fixtures/test.txt"
    @test_film = Film.from_file(test_file_path)
  end

  it 'should do ok for initialize from_file' do
    expect(@test_film.name).to eq 'Test name'
    expect(@test_film.producer).to eq 'Test producer'
    expect(@test_film.year_of_issue).to eq '2010'
  end

  it 'should do ok for to_s' do
    expect(@test_film.to_s).to eq 'Test producer - Test name (2010)'
  end

end
