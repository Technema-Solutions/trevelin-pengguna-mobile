import '../../features/speedboat/domain/entities/speedboat_ticket.dart';
import '../../features/speedboat/domain/entities/travel_package.dart';

class MockDataProvider {
  // Popular speedboat routes
  static List<SpeedboatTicket> get popularSpeedboatRoutes => [
        SpeedboatTicket(
          id: 'sb001',
          from: 'Tarakan',
          to: 'Bulungan',
          departureDate: DateTime.now().add(const Duration(days: 1)),
          departureTime: '08:00',
          arrivalTime: '09:15',
          duration: '1h 15m',
          price: 155000,
          availability: 8,
          status: 'limited',
          boatName: 'Express 1',
          boatLogo: 'https://via.placeholder.com/100',
          serviceType: ServiceType.reguler,
          availableSeats: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'D1', 'D2'],
        ),
        SpeedboatTicket(
          id: 'sb002',
          from: 'Tarakan',
          to: 'Derawan',
          departureDate: DateTime.now().add(const Duration(days: 1)),
          departureTime: '12:00',
          arrivalTime: '14:30',
          duration: '2h 30m',
          price: 280000,
          availability: 15,
          status: 'available',
          boatName: 'Island Explorer',
          boatLogo: 'https://via.placeholder.com/100',
          serviceType: ServiceType.nonReguler,
        ),
        SpeedboatTicket(
          id: 'sb003',
          from: 'Tarakan',
          to: 'Nunukan',
          departureDate: DateTime.now().add(const Duration(days: 2)),
          departureTime: '06:30',
          arrivalTime: '08:45',
          duration: '2h 15m',
          price: 195000,
          availability: 12,
          status: 'available',
          boatName: 'Ocean Star',
          boatLogo: 'https://via.placeholder.com/100',
          serviceType: ServiceType.reguler,
          availableSeats: ['A1', 'A2', 'A3', 'B1', 'B2', 'B3'],
        ),
      ];

  // Popular travel packages
  static List<TravelPackage> get popularTravelPackages => [
        TravelPackage(
          id: 'tp001',
          name: 'Derawan Island Explorer 3D2N',
          destination: 'Kepulauan Derawan',
          description:
              'Jelajahi keindahan Kepulauan Derawan dengan paket wisata lengkap yang mencakup snorkeling, island hopping, dan pengalaman melihat penyu bertelur.',
          packageType: PackageType.openTrip,
          price: 2850000,
          duration: '3 hari 2 malam',
          minParticipants: 1,
          maxParticipants: 12,
          currentParticipants: 8,
          highlights: [
            'Snorkeling di 4 pulau eksotis',
            'Swimming with stingless jellyfish di Kakaban',
            'Sunset di Maratua Island',
            'Traditional fishing experience',
            'Turtle watching di Sangalaki'
          ],
          includes: [
            'Transportasi speedboat PP',
            'Homestay AC 2 malam',
            'Makan 3x sehari',
            'Snorkeling gear',
            'Tour guide berpengalaman',
            'Life jacket',
            'Underwater camera rental'
          ],
          excludes: [
            'Tiket pesawat ke Tarakan',
            'Asuransi perjalanan',
            'Pengeluaran pribadi',
            'Tips guide',
            'Minuman beralkohol'
          ],
          facilities: [
            'Kapal speedboat berlisensi',
            'Life jacket safety standard',
            'Snorkeling equipment lengkap',
            'Underwater camera profesional',
            'First aid kit',
            'Communication device'
          ],
          requirements: [
            'Umur minimal 12 tahun',
            'Bisa berenang minimal basic',
            'Tidak sedang hamil',
            'Tidak memiliki penyakit jantung',
            'Membawa pakaian renang'
          ],
          meetingPoint: 'Pelabuhan Tengkayu 1, Tarakan',
          departurePoint: 'Tarakan',
          departureDate: DateTime.now().add(const Duration(days: 7)),
          returnDate: DateTime.now().add(const Duration(days: 10)),
          organizer: 'Derawan Explorer Tours',
          organizerLogo: 'https://via.placeholder.com/100',
          isVerified: true,
          rating: 4.8,
          totalReviews: 124,
          images: [
            'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19',
            'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2',
          ],
        ),
        TravelPackage(
          id: 'tp002',
          name: 'Maratua Paradise 2D1N',
          destination: 'Pulau Maratua',
          description:
              'Nikmati ketenangan Pulau Maratua dengan pemandangan pantai yang memukau dan aktivitas snorkeling yang menakjubkan.',
          packageType: PackageType.privateTrip,
          price: 1950000,
          duration: '2 hari 1 malam',
          minParticipants: 4,
          maxParticipants: 8,
          currentParticipants: 2,
          highlights: [
            'Private beach experience',
            'Snorkeling premium spots',
            'Sunset dinner di pantai',
            'Photography session'
          ],
          includes: [
            'Transportasi speedboat PP',
            'Resort accommodation',
            'All meals included',
            'Snorkeling equipment',
            'Professional guide'
          ],
          excludes: ['Personal expenses', 'Tips for guide', 'Travel insurance'],
          facilities: [
            'Luxury speedboat',
            'Premium snorkeling gear',
            'Professional camera',
            'Safety equipment'
          ],
          requirements: [
            'Minimum age 10 years',
            'Basic swimming ability',
            'Health certificate'
          ],
          meetingPoint: 'Berau Dock',
          departurePoint: 'Berau',
          departureDate: DateTime.now().add(const Duration(days: 5)),
          returnDate: DateTime.now().add(const Duration(days: 7)),
          organizer: 'Maratua Adventures',
          organizerLogo: 'https://via.placeholder.com/100',
          isVerified: true,
          rating: 4.7,
          totalReviews: 89,
          images: [
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
          ],
        ),
      ];

  // Get recent activities for dashboard
  static List<Map<String, dynamic>> get recentActivities => [
        {
          'id': 'activity_1',
          'type': 'speedboat',
          'title': 'Speedboat Express - Tarakan → Bulungan',
          'date': DateTime.now().subtract(const Duration(hours: 2)),
          'status': 'completed',
          'price': 155000,
        },
        {
          'id': 'activity_2',
          'type': 'package',
          'title': 'Derawan Island Explorer 3D2N',
          'date': DateTime.now().subtract(const Duration(days: 1)),
          'status': 'upcoming',
          'price': 2850000,
        },
      ];
}
