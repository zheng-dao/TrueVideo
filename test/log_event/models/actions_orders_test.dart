import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_orders.dart';

void main() {
  group(
    'LogEventActionOrders',
    () {
      test(
        'create',
        () {
          // Given
          const sut = LogEventActionOrders.create;
          List resultExpected = [
            'create',
            0,
            'event_orders_create',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'update',
        () {
          // Given
          const sut = LogEventActionOrders.update;
          List resultExpected = [
            'update',
            1,
            'event_orders_update',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'validateJobServiceNumber',
        () {
          // Given
          const sut = LogEventActionOrders.validateJobServiceNumber;
          List resultExpected = [
            'validateJobServiceNumber',
            2,
            'event_orders_validate_job_service_number',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );
    },
  );
}
