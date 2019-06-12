class SearchDnsHostnamesAsJson
  include Interactor

  def call
    context.response = {}
    context.response['total'] = context.total.as_json
    context.response['dns'] = context.dns.as_json(only: [:id, :IP])
    context.response['hostnames'] = context.hostnames.as_json(only: [:name, :match])
  end
end
