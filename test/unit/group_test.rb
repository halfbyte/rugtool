require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  should_require_attributes :title, :url_slug, :description
  
  context "validations" do
    setup do
      Factory(:group)
    end
    should_require_unique_attributes :url_slug    
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
  
  
end
