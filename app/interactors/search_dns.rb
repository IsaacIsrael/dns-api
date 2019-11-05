class SearchDns
  include Interactor

  def call
    context.dns = Dns.filter(context.filter)
  end
end
