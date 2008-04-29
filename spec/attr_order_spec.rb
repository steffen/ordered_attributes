require File.dirname(__FILE__) + '/spec_helper'

class Company < ActiveRecord::Base
  
  attr_order :name, :street, :zip, :city
  
end


describe Company, "with attr_order" do
   
   # before(:each) do
   #   @company = Company.new
   # end
   
   it "should have a ordered_attributes class method" do
     Company.respond_to?(:ordered_attributes).should == true
   end

end

describe Company, ".ordered_attributes" do
   
   before(:each) do
     @company = Company.new
     @company.attributes.keys.should == ["name", "city", "zip", "street"] # not sure if this order is always applied by default, but added this test to make sure the plugin actually has an effect
   end
   
   it "should return ordered attributes" do
     Company.ordered_attributes.should == [:name, :street, :zip, :city]
   end
   
   it "should return custom attributes" do
     Company.ordered_attributes([:street, :zip, :city]).should == [:street, :zip, :city]
   end

end


class Person < ActiveRecord::Base
  
  attr_order :name, :street, :zip, :city
  
  attr_groups :address => [:street, :zip, :city],
              :all => [:address, :name]
  
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
   
   it "should return group in group attributes" do
     Person.ordered_attributes([:all]).should == [:street, :zip, :city, :name]
   end

end