# frozen_string_literal: true

module Trailblazer
  module Macro
    module Contract
      def self.Persist(method: :save, name: "default")
        path = :"contract.#{name}"
        step = ->(ctx, **) { ctx[path].send(method) }

        task = Activity::Circuit::TaskAdapter.for_step(step)
        id = if name == 'default'
               "persist.#{method}"
             else
               "#{path}.persist.#{method}"
             end
        {
          task: task,
          id: id
        }
      end
    end
  end
end
