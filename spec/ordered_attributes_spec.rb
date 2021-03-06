require File.dirname(__FILE__) + '/spec_helper'

class Company < ActiveRecord::Base
  
  attr_order :name, :street, :zip, :city
  
end


describe Company, "with attr_order" do
   
   it "should have a ordered_attributes class method" do
     Company.respond_to?(:ordered_attributes).should == true
   end

end

describe Company, ".ordered_attributes" do
   
   before(:each) do
     @company = Company.new
     @company.attributes.keys.should == ["name", "city", "zip", "street"] # not sure if this order is always applied by default, but added this test to make sure the plugin actually has an effect
   end
   
   it "should return default ordered attributes, when no arguments are passed" do
     Company.ordered_attributes.should == [:name, :street, :zip, :city]
   end
   
   it "should return default ordered attributes, when empty array is passed" do
     Company.ordered_attributes([]).should == [:name, :street, :zip, :city]
   end
   
   it "should return default ordered attributes, when array with empty array is passed" do
     Company.ordered_attributes([[]]).should == [:name, :street, :zip, :city]
   end
   
   it "should return custom attributes, when passed as array of symbols" do
     Company.ordered_attributes([:street, :zip, :city]).should == [:street, :zip, :city]
   end
   
   it "should return custom attributes, when passed as array of strings" do
     Company.ordered_attributes(%w(street zip city)).should == [:street, :zip, :city]
   end
   
   it "should return custom attributes, when passed as arguments" do
     Company.ordered_attributes(:street, :zip, :city).should == [:street, :zip, :city]
   end

end

describe Company, "any method with wildcard arguments that is calling .ordered_attributes" do
  
  def wildcard(*attributes)
    Company.ordered_attributes(attributes)
  end
  
  it "should return default ordered attributes, when no arguments are passed" do
    wildcard.should == [:name, :street, :zip, :city]
  end
  
  it "should return custom attributes, when arguments are passed" do
    wildcard(:zip, :city).should == [:zip, :city]
  end
  
end


class Client < ActiveRecord::Base
  
  attr_order %w(name street zip city)
  
end


describe Client, "with an array passed to attr_order" do
   
  it "should return default ordered attributes, when no arguments are passed" do
    Client.ordered_attributes.should == [:name, :street, :zip, :city]
  end

end


class Person < ActiveRecord::Base
  
  attr_order :name, :street, :zip, :city
  
  attr_groups :address => [:street, :zip, :city],
              :birth => %w(date_of_birth place_of_birth),
              :all => [:name, :address, :birth]
  
end


describe Person, ".ordered_attributes with group in group" do
   
   before(:each) do
     @person = Person.new
     @person.attributes.keys.should == ["name", "city", "zip", "street"] # not sure if this order is always applied by default, but added this test to make sure the plugin actually has an effect
   end
   
   it "should return ordered attributes" do
     Person.ordered_attributes.should == [:name, :street, :zip, :city]
   end
   
   it "should return group attributes" do
     Person.ordered_attributes([:address]).should == [:street, :zip, :city]
   end
   
   it "should return group attributes and convert the attribute names to symbols" do
     Person.ordered_attributes(:birth).should == [:date_of_birth, :place_of_birth]
   end
   
   it "should return group in group attributes, when passed as array" do
     Person.ordered_attributes([:all]).should == [:name, :street, :zip, :city, :date_of_birth, :place_of_birth]
   end
   
   it "should return group in group attributes, when passed as argument" do
     Person.ordered_attributes(:all).should == [:name, :street, :zip, :city, :date_of_birth, :place_of_birth]
   end

end