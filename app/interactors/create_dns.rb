class CreateDns
  include Interactor

  def call
    # TODO
    dns = Dns.new(IP: context.IP)
    dns.save
  end
end
