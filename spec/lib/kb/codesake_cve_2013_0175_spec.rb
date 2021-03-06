require 'spec_helper'

describe "CVE-2013-0175 security check" do
  let (:check) {Codesake::Dawn::Kb::CVE_2013_0175.new}
  it "knows its name" do
    check.name.should == "CVE-2013-0175"
  end 
  it "has a 7.5 cvss score" do
    check.cvss_score == 7.5
  end

  it "fires when multi_xml vulnerable gem it has been found" do
    check.dependencies = [{:name=>"multi_xml", :version=>"0.5.2"}]
    check.vuln?.should be_true
  end
  it "fires when Grape vulnerable gem it has been found" do
    check.dependencies = [{:name=>"grape", :version=>"0.2.5"}]
    check.vuln?.should be_true
  end
  it "fires when multi_xml gem is not vulnerable but Grape is" do
    check.dependencies = [{:name=>"grape", :version=>"0.2.5"}, {:name=>"multi_xml", :version=>"0.5.3"}]
    check.vuln?.should be_true
  end
  it "fires when multi_xml gem is vulnerable but Grape is not" do
    check.dependencies = [{:name=>"grape", :version=>"0.2.6"}, {:name=>"multi_xml", :version=>"0.5.2"}]
    check.vuln?.should be_true
  end

  it "doesn't fire when no vulnerabilities were found" do
    check.dependencies = [{:name=>"grape", :version=>"0.2.6"}, {:name=>"multi_xml", :version=>"0.5.3"}]
    check.vuln?.should be_false
  end


end
