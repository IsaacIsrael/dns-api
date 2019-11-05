class FilterDnsHostnamesPerPage
  include Interactor

  def call
    context.limit = context.limit || 5
    context.total = context.dns.count
    context.dns = context.dns.page(context.page).per(context.limit)
    context.hostnames = context.hostnames.where(id: Hostname
                                                      .joins(:dns)
                                                      .where('dns.id IN (?)', context.dns.select('id'))
                                                      .select('id'))
  end
end
