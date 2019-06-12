class Api::V1::DnsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:page]
      result = SearchDnsHostname.call(page: params[:page], filter: filter)
      render json: result.response, status: :ok
    else
      render json: { error: 'Page params is required' }, status: :bad_request
    end
  end

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

  def filter
    { included: params[:included], excluded: params[:excluded] }
  end
end
