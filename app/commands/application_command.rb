class ApplicationCommand
  include ActiveModel::Model

  class << self
    def call(*args)
      new(*args).tap do |command|
        command.send(:call) if command.valid?
      end
    end

    def call!(*args)
      new(*args).tap do |command|
        command.send(:raise_validation_error) if command.valid?
      end
    end
  end

  def success?
    errors.none?
  end

  def failure?
    not success?
  end

  private

  def call
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def raise_validation_error()
    raise ActiveRecord::RecordInvalid.new(self)
  end
end
