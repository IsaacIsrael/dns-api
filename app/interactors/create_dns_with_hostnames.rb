class CreateDnsWithHostnames
  include Interactor::Organizer

  organize CreateDns, AddHostnames
end
