class AddHostnames
  include Interactor

  def call
    context.hostnames.each do |hostname|
      context.dns.hostnames << Hostname.find_or_create_by(name: hostname)
    end
  end
end
