module Svgeez
  class Command
    class << self
      def subclasses
        @subclasses ||= []
      end

      def inherited(base)
        subclasses << base
        super(base)
      end

      def init_with_program(program)
        program.command(name.split('::').last.downcase.to_sym) do |command|
          command.description command_description
          command.syntax command_syntax

          add_actions(command)
          add_options(command)
        end
      end

      private

      def add_actions(command)
        command.action do |_, options|
          command_action(options)
        end
      end

      def add_options(command)
        command.option 'source', '-s', '--source [FOLDER]', 'Source folder (defaults to ./_svgeez)'
        command.option 'destination', '-d', '--destination [OUTPUT]', 'Destination file or folder (defaults to ./svgeez.svg)'
        command.option 'svgo', '--with-svgo', 'Optimize source SVGs with SVGO before sprite generation (non-destructive)'
        command.option 'attributes', '-a', '--attributes [ATTRS]', 'Attributes for the outputted SVG file (defaults to \'style="display:none;"\''
      end
    end
  end
end
