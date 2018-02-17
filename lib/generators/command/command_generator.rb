class CommandGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_command_file
    destination = Rails.root.join("app/commands/#{name.underscore}_command.rb")
    template('command.rb.erb', destination)
  end


  #def create_spec_file
  #  destination = Rails.root.join("spec/commands/#{name.underscore}_command_spec.rb")
  #  template('spec.rb.erb', destination)
  #end
end
