class SearchDnsHostname
  include Interactor::Organizer

  organize SearchDns, SearchHostname, FilterDnsHostnamesPerPage, SearchDnsHostnamesAsJson
end
