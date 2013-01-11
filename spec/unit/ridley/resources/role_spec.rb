require 'spec_helper'

describe Ridley::Role do
  it_behaves_like "a Ridley Resource", Ridley::Role

  let(:connection) { double("connection") }

  subject { Ridley::Role.new(connection) }

  describe "#set_override_attribute" do
    it "sets an override node attribute at the nested path" do
       subject.set_override_attribute('deep.nested.item', true)

       subject.override_attributes.should have_key("deep")
       subject.override_attributes["deep"].should have_key("nested")
       subject.override_attributes["deep"]["nested"].should have_key("item")
       subject.override_attributes["deep"]["nested"]["item"].should be_true
    end

    context "when the override attribute is already set" do
      it "test" do
        subject.override_attributes = {
          deep: {
            nested: {
              item: false
            }
          }
        }
        subject.set_override_attribute('deep.nested.item', true)
        
        subject.override_attributes["deep"]["nested"]["item"].should be_true
      end
    end
  end

  describe "#set_default_attribute" do
    it "sets an override node attribute at the nested path" do
       subject.set_default_attribute('deep.nested.item', true)

       subject.default_attributes.should have_key("deep")
       subject.default_attributes["deep"].should have_key("nested")
       subject.default_attributes["deep"]["nested"].should have_key("item")
       subject.default_attributes["deep"]["nested"]["item"].should be_true
    end

    context "when the override attribute is already set" do
      it "test" do
        subject.default_attributes = {
          deep: {
            nested: {
              item: false
            }
          }
        }
        subject.set_default_attribute('deep.nested.item', true)
        
        subject.default_attributes["deep"]["nested"]["item"].should be_true
      end
    end
  end
end
