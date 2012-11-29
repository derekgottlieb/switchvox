require 'spec_helper'

describe Switchvox do
  it 'should test_object' do
    json = {"string" => "value"}.to_json
    obj  = JSON.parse(json).to_obj
    obj.string.should == 'value'
  end

  it 'should test test_nested_object' do
    json = {"dogs" => {"retriever" => "sparky", "basset" => "jennie", "pinscher" => "carver"}}.to_json
    obj  = JSON.parse(json).to_obj
    obj.dogs.retriever.should == 'sparky'
  end

  it 'should test test_array_of_objects' do
    json = [{"retriever" => "sparky"}, {"basset" => "jennie"}, {"pinscher" => "carver"}].to_json
    obj  = JSON.parse(json).to_obj
    obj[0].retriever.should == "sparky"
  end

  it 'should test test_deep_nest_mixed' do
    input = {"kennels" => [
            {"dallas" => [
             {"name" => "north"},
             {"name"  => "east"},
            ]},
            {"frisco" => [
             {"name" => "south"},
             {"name"  => "west"}
            ],
            "company" => "Doggie Daze"
            }
          ]}

    obj  = JSON.parse(input.to_json).to_obj

    obj.kennels.should == input.kennels
    obj.kennels[1].should == input.kennels[1]
    obj.kennels[1].frisco.should == input.kennels[1].frisco
    obj.kennels[1].frisco[0].name.should == input.kennels[1].frisco[0].name
  end

  it 'should test test_deep_nest_hash' do
    json = {"kennels" => {
            "kennel" => {
            "dallas" => ["north", "south"],
            "frisco" => ["east", "west"]}}
           }.to_json
    obj  = JSON.parse(json).to_obj
    pp obj
    obj.kennels.kennel.dallas[0].should == 'north'
  end
end
