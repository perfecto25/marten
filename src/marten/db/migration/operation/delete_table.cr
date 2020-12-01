module Marten
  module DB
    abstract class Migration
      module Operation
        class DeleteTable < Base
          @name : String

          def initialize(name : String | Symbol)
            @name = name.to_s
          end

          def mutate_db_backward(
            app_label : String,
            schema_editor : Management::SchemaEditor::Base,
            from_state : Management::ProjectState,
            to_state : Management::ProjectState
          ) : Nil
            table = to_state.get_table(app_label, @name)
            schema_editor.create_table(table)
          end

          def mutate_db_forward(
            app_label : String,
            schema_editor : Management::SchemaEditor::Base,
            from_state : Management::ProjectState,
            to_state : Management::ProjectState
          ) : Nil
            table = from_state.get_table(app_label, @name)
            schema_editor.delete_table(table)
          end

          def mutate_state_forward(app_label : String, state : Management::ProjectState) : Nil
            state.delete_table(app_label, @name)
          end
        end
      end
    end
  end
end