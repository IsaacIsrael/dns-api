class SearchHostname
  include Interactor

  def call
     context.hostnames = Hostname.joins(:dns)
                        .where('dns.id IN (?)', context.dns.select('id'))
                        .group('hostnames.id, name')
                        .select('hostnames.id ,name , COUNT(name) as match')
  end
end
