require "./migration/**"

module Marten
  module DB
    abstract class Migration
      def operations
      end
    end
  end
end
