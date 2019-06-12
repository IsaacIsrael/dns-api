class Api::V1::DnsController < ApplicationController
  def create
    result = CreateDnsWithHostnames.call(dns_params)
    render json: result.dns.as_json(only: [:id]), status: :created
  end

  private

  def dns_params
    params.permit(:IP, hostnames: [])
  end
end
