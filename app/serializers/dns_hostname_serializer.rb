class DnsHostnameSerializer < ActiveModel::Serializer
  attributes :dns, :hostnames
  def dns
    byebug
  end

  def hostnames
  end
end
