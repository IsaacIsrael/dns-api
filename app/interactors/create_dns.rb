class CreateDns
  include Interactor

  def call
    dns = Dns.new(IP: context.IP)

    if dns.save
      context.dns = dns
    else
      context.fail!(errors: dns.errors.messages)
    end
  end
end
