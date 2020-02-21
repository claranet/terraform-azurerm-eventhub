locals {
  default_tags = {
    env   = var.environment
    stack = var.stack
  }

  # Generate a default name
  default_name = "${var.stack}-${var.client_name}-${var.location_short}-${var.environment}"

  # Generate a list of queues to create
  queues_list = flatten(
    [for namespace, values in var.servicebus_namespaces_queues :
      [for queuename in keys(lookup(values, "queues", {})) :
        "${namespace}|${queuename}"
      ]
    ]
  )

  # Generate a list of queues to create shared access policies with reader right
  queues_reader = flatten(
    [for namespace, values in var.servicebus_namespaces_queues :
      [for queuename, params in lookup(values, "queues", {}) :
        "${namespace}|${queuename}" if lookup(params, "reader", false)
      ]
    ]
  )

  # Generate a list of queues to create shared access policies with sender right
  queues_sender = flatten(
    [for namespace, values in var.servicebus_namespaces_queues :
      [for queuename, params in lookup(values, "queues", {}) :
        "${namespace}|${queuename}" if lookup(params, "sender", false)
      ]
    ]
  )

  # Generate a list of queues to create shared access policies with manage right
  queues_manage = flatten(
    [for namespace, values in var.servicebus_namespaces_queues :
      [for queuename, params in lookup(values, "queues", {}) :
        "${namespace}|${queuename}" if lookup(params, "manage", false)
      ]
    ]
  )
}
