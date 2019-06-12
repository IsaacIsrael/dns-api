class SearchDns
  include Interactor

  def call
    context.dns = Dns.all
  end
end
