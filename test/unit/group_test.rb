require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :url_slug, :description
  
  context "validations" do
    setup do
      Factory(:group)
    end
    should_validate_uniqueness_of :url_slug
    
    should "not allow blacklisted group slugs" do
      group = Factory.build(:group)
      Group::BLACKLISTED_URL_SLUGS.each do |name|
        group.url_slug = name
        assert !group.valid?, "group is not invalid with url slug <#{name}>"
      end
    end
    
  end
  
  context "additional validations" do
    setup do
      @group = Group.new(:title => 'test', :description => 'description', :url_slug => 'test_url-slug')
    end
    should "validate format of url_slug" do
      assert @group.valid?
    end
    
    should "not validate if url_slug contains bad characters" do
      @group.url_slug = "fooäü"
      assert !@group.valid?
    end
    should "not validate if url_slug contains bad signs" do
      @group.url_slug = "woo+"
      assert !@group.valid?
    end
  end
  
  context "to_param" do
    should "form correct to_param" do
      group = Group.new(:title => 'test', :description => 'description', :url_slug => 'test_url_slug')
      assert_equal "test_url_slug", group.to_param
    end
  end

  context "geocoding" do
    should "call geocoder" do
      group = Factory.build(:group, :location => 'hamburg')
      group.expects(:geocode_for).with('hamburg').returns([1.0,2.0])
      assert group.valid?
    end
    
    should "return geocoded? if geocoded" do
      group = Factory.build(:group, :location => 'hamburg', :lat => 10.0, :lng => 55.2)
      assert group.geocoded?
    end
    
  end
end
