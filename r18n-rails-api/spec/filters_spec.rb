# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe 'Rails filters' do

  it "uses named variables" do
    i18n = R18n::Translation.new(EN, '', :locale => EN,
      :translations => { 'echo' => 'Value is %{value}' })

    i18n.echo(:value => 'R18n').should == 'Value is R18n'
    i18n.echo(:value => -5.5).should   == 'Value is −5.5'
    i18n.echo(:value => 5000).should   == 'Value is 5,000'
    i18n.echo(:value => '<b>').should  == 'Value is &lt;b&gt;'
    i18n.echo.should == 'Value is %{value}'
  end

  it "uses old variables syntax" do
    i18n = R18n::Translation.new(EN, '', :locale => EN,
      :translations => { 'echo' => 'Value is {{value}}' })
    i18n.echo(:value => 'Old').should == 'Value is Old'
  end

  it "pluralizes by variable %{count}" do
    i18n = R18n::Translation.new(EN, '', :locale => EN,
      :translations => {
        'users' => R18n::Typed.new('pl', {
          0 => 'no users',
          1 => '1 user',
          'n' => '%{count} users'
        })
      })

    i18n.users(:count => 0).should == 'no users'
    i18n.users(:count => 1).should == '1 user'
    i18n.users(:count => 5).should == '5 users'
  end

end
