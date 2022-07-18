enum LogEventActionOrders {
  create,
  update,
  validateJobServiceNumber,
}

extension LogEventActionOrdersEx on LogEventActionOrders {
  String get eventName {
    const prefix = "event_orders";

    switch (this) {
      case LogEventActionOrders.create:
        return "${prefix}_create";
      case LogEventActionOrders.update:
        return "${prefix}_update";
      case LogEventActionOrders.validateJobServiceNumber:
        return "${prefix}_validate_job_service_number";
    }
  }
}
