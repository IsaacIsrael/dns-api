class Api::V1::DnsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    result = CreateDnsWithHostnames.call(dns_params)
    if result.success?
      render json: result.dns.as_json(only: [:id]), status: :created
    else
      render json: { error: result.errors }, status: :bad_request
    end
  end

  private

  def dns_params
    params.permit(:IP, hostnames: [])
  end
end
