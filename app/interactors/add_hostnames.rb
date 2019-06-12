class AddHostnames
  include Interactor

  def call
    ActiveRecord::Base.transaction do
      context.hostnames.each do |hostname|
        context.dns.hostnames << Hostname.find_or_create_by(name: hostname)
      end
    rescue ActiveRecord::RecordInvalid => exception
      context.fail!(errors: exception.message)
      raise ActiveRecord::Rollback
    end
  end
end
