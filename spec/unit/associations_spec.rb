require 'pathname'
require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

require ROOT_DIR + 'lib/data_mapper/associations.rb'

describe "DataMapper::Associations" do
  before :each do
    @relationship = mock(DataMapper::Associations::Relationship)
    @n = 1.0/0
  end

  describe ".has" do
    it "should allow a declaration" do
      lambda do
        class Manufacturer
          has 1, :halo_car
        end
      end.should_not raise_error
    end

    describe "one-to-one syntax" do
      it "should create a basic one-to-one association" do
        Manufacturer.should_receive(:one_to_one).
          with(:halo_car,{}).
          and_return(@relationship)
        class Manufacturer
          has 1, :halo_car
        end
      end

      it "should create a one-to-one association with options" do
        Manufacturer.should_receive(:one_to_one).
          with(:halo_car, {:class_name => 'Car', :repository_name => 'other'}).
          and_return(@relationship)
        class Manufacturer
          has 1, :halo_car, 
            :class_name => 'Car',
            :repository_name => 'other'
        end
      end
    end
    
    describe "one-to-many syntax" do
      it "should create a basic one-to-many association with no constraints" do
        Manufacturer.should_receive(:one_to_many).
          with(:vehicles,{}).
          and_return(@relationship)
        class Manufacturer
          has 1..n, :vehicles
        end
      end
      
      it "should create a one-to-many association with fixed constraint" do
        Manufacturer.should_receive(:one_to_many).
          with(:vehicles,{:min=>4, :max=>4}).
          and_return(@relationship)
        class Manufacturer
          has 1..4, :vehicles
        end
      end
      
      it "should create a one-to-many association with min/max constraints" do
        pending
      end

      it "should create a one-to-many association with options" do
        Manufacturer.should_receive(:one_to_many).
          with(:vehicles,{:class_name => 'Car'}).
          and_return(@relationship)
        class Manufacturer
          has 1..n, :vehicles,
            :class_name => 'Car'
        end
      end
    end
    
    describe "many-to-one syntax" do
      it "should create a basic many-to-one association with no constraints" do
        Manufacturer.should_receive(:many_to_one).
          with(:vehicles,{}).
          and_return(@relationship)
        class Manufacturer
          has n..1, :vehicles
        end
      end
      
      it "should create a many-to-one association with fixed constraint" do
        Manufacturer.should_receive(:many_to_one).
          with(:vehicles,{:min=>4, :max=>4}).
          and_return(@relationship)
        class Manufacturer
          has 4..1, :vehicles
        end
      end

      it "should create a many-to-one association with min/max constraints" do
        pending
      end

      it "should create a many-to-one association with options" do
        Manufacturer.should_receive(:many_to_one).
          with(:vehicles,{:class_name => 'Car'}).
          and_return(@relationship)
        class Manufacturer
          has n..1, :vehicles,
            :class_name => 'Car'
        end
      end
    end
    
    describe "many-to-many syntax" do
      it "should create a basic many-to-one association with no constraints" do
        Manufacturer.should_receive(:many_to_many).
          with(:vehicles,{}).
          and_return(@relationship)
        class Manufacturer
          has n..n, :vehicles
        end
      end
      
      it "should create a many-to-many association with fixed constraints" do
        Manufacturer.should_receive(:many_to_many).
          with(:vehicles, :left=>{:min=>4, :max=>4}, :right=>{:min=>4, :max=>4}).
          and_return(@relationship)
        class Manufacturer
          has 4..4, :vehicles
        end
      end

      it "should create a many-to-many association with min/max constraints" do
        pending
      end

      it "should create a many-to-many association with options" do
        Manufacturer.should_receive(:many_to_many).
          with(:vehicles,{:class_name => 'Car'}).
          and_return(@relationship)
        class Manufacturer
          has n..n, :vehicles, 
            :class_name => 'Car'
        end
      end
    end
  end
end

