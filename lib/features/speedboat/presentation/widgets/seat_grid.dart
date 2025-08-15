import 'package:flutter/material.dart';
import '../../domain/entities/seat.dart';

/// Grid widget displaying seats with selection state.
class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key, required this.seats, required this.onTap, required this.selectedSeatIds});

  final List<Seat> seats;
  final void Function(String) onTap;
  final Set<String> selectedSeatIds;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: seats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final seat = seats[index];
        Color color;
        if (seat.status == SeatStatus.sold) {
          color = Colors.grey;
        } else if (selectedSeatIds.contains(seat.id)) {
          color = Colors.green;
        } else {
          color = Colors.white;
        }
        return Semantics(
          label: 'Seat ${seat.code}',
          button: true,
          enabled: seat.status != SeatStatus.sold,
          child: GestureDetector(
            onTap: seat.status == SeatStatus.sold ? null : () => onTap(seat.id),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black),
              ),
              child: Center(child: Text(seat.code)),
            ),
          ),
        );
      },
    );
  }
}
