# # db/seeds.rb
# Première version : jeu de données minimal.
# Sans photos (ActiveStorage) ni géocodage automatique : les coordonnées
# sont renseignées à la main (geocoder sera branché plus tard).
#
# /!\ Tant que geocoder n'est pas installé, garde le callback `geocode`
#     COMMENTÉ dans le modèle Flat, sinon ce fichier plantera au premier flat.

puts "Nettoyage de la base (enfants -> parents)..."
Review.destroy_all
Booking.destroy_all
Flat.destroy_all
User.destroy_all

puts "Création des utilisateurs..."
alice = User.create!(first_name: "Alice", last_name: "Martin",  email: "alice@example.com")
bob   = User.create!(first_name: "Bob",   last_name: "Durand",  email: "bob@example.com")
chloe = User.create!(first_name: "Chloé", last_name: "Lefèvre", email: "chloe@example.com")
driss = User.create!(first_name: "Driss", last_name: "Benali",  email: "driss@example.com")

puts "Création des logements..."
studio = Flat.create!(
  name: "Studio cosy en centre-ville",
  description: "Petit studio lumineux à deux pas du château des ducs de Bretagne.",
  address: "10 rue de Strasbourg, 44000 Nantes",
  price_by_night: 55,
  capacity: 2,
  latitude: 47.2173,
  longitude: -1.5534,
  user: alice                       # Alice est l'hôte
)

loft = Flat.create!(
  name: "Loft sur l'Île de Nantes",
  description: "Grand loft industriel face aux Machines de l'île.",
  address: "5 quai des Antilles, 44200 Nantes",
  price_by_night: 110,
  capacity: 4,
  latitude: 47.2048,
  longitude: -1.5658,
  user: alice
)

maison = Flat.create!(
  name: "Maison de bord de mer",
  description: "Maison familiale à 200 m de la plage, idéale pour les vacances.",
  address: "12 avenue de l'Océan, 44500 La Baule",
  price_by_night: 180,
  capacity: 6,
  latitude: 47.2861,
  longitude: -2.3920,
  user: bob
)

puts "Création des réservations..."
# total_price calculé depuis le nombre de nuits ; end_date = start_date + nuits
# (garantit end_date > start_date, donc passe la validation custom du Booking).
bookings_data = [
  { user: chloe, flat: studio, start: Date.today - 30, nights: 3 }, # séjour passé -> avis
  { user: driss, flat: maison, start: Date.today - 15, nights: 5 }, # séjour passé -> avis
  { user: chloe, flat: loft,   start: Date.today + 20, nights: 4 }  # séjour à venir -> pas d'avis
]

bookings = bookings_data.map do |d|
  Booking.create!(
    user:        d[:user],
    flat:        d[:flat],
    start_date:  d[:start],
    end_date:    d[:start] + d[:nights],
    total_price: d[:nights] * d[:flat].price_by_night
  )
end

puts "Création des avis (un seul par réservation, sur les séjours passés)..."
Review.create!(
  content: "Studio parfait, hôte très réactive et emplacement idéal.",
  rating: 5,
  booking: bookings[0]
)
Review.create!(
  content: "Très belle maison, séjour agréable. Literie un peu ferme.",
  rating: 4,
  booking: bookings[1]
)

puts "Terminé : #{User.count} users, #{Flat.count} flats, " \
     "#{Booking.count} bookings, #{Review.count} reviews."
