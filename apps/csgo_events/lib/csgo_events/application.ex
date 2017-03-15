defmodule CsgoEvents.Application do
  use Application

  def start(_start_type, _start_args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(CsgoEvents.Builder, [])
    ]

    opts = [strategy: :one_for_one, name: CsgoEvents.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
