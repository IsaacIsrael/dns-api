class SearchHostname
  include Interactor

  def call
    filter = (context.filter&.[](:included) || []) + (context.filter&.[](:excluded) || [])
    context.hostnames = Hostname.joins(:dns)
                                .where('dns.id IN (?)', context.dns.select('id'))
                                .group('hostnames.id, name')
                                .where.not(name: filter)
                                .select('hostnames.id ,name , COUNT(name) as match')
  end
end
