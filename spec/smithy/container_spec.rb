require "smithy/container"

module Smithy
  describe Container do
    describe "#instance" do
      context "name is registered to a class without dependencies" do
        let(:component_class) { Class.new }

        before do
          subject.register(:component, component_class)
        end

        it "returns a new instance of the class" do
          subject.instance(:component).should be_kind_of(component_class)
        end
      end

      context "name is registered to a class with inferred dependencies" do
        let(:dependency) { Object.new }
        let(:component_class) do
          Class.new do
            attr_reader :dependency

            def initialize(dependency)
              @dependency = dependency
            end
          end
        end

        before do
          subject.register(:component, component_class)
          subject.register(:dependency, dependency)
        end

        it "infers the dependency by parameter name" do
          subject.instance(:component).dependency.should == dependency
        end
      end

      context "name is registered to a class with explicit dependencies" do
        let(:dependency) { Object.new }

        let(:component_class) do
          Class.new do
            attr_reader :dependency

            def initialize(dependency)
              @dependency = dependency
            end
          end
          end

          before do
            subject.register(:component, component_class, :explicit_dependency)
            subject.register(:explicit_dependency, dependency)
          end

          it "injects the dependent object into the constructor" do
            subject.instance(:component).dependency.should == dependency
          end
        end

        context "name is registered to an object" do
          let(:component) { Object.new }

          before do
            subject.register(:component, component)
          end

          it "returns the instance of the object" do
            subject.instance(:component).should == component
          end
        end

        context "name is not registered" do
          it "raises" do
            expect { subject.instance(:not_registered) }.to raise_error(UnsatisfiedDependencyError)
          end
        end
      end
    end
  end
