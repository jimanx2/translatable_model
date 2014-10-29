require 'test_helper'
require 'generators/translatable_model/translatable_model_generator'

class TranslatableModelGeneratorTest < Rails::Generators::TestCase
  tests TranslatableModelGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
