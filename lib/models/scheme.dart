class Scheme {
  final String name;
  final String image;
  final String description;
  final List<String> eligibility;
  final String applicationLink;

  const Scheme({
    required this.name,
    required this.image,
    required this.description,
    required this.eligibility,
    required this.applicationLink,
  });
}

// Sample scheme data
final List<Scheme> schemes = [
  Scheme(
    name: 'Paramparagat Krishi Vikas Yojana (PKVY)',
    image: 'images/PKVY.png',
    description:
        'PKVY is a sub-component of Soil Health Management (SHM) under National Mission of Sustainable Agriculture (NMSA). The scheme promotes organic farming through adoption of organic village by cluster approach and PGS certification.',
    eligibility: [
      'Farmers who are willing to adopt organic farming',
      'Farmers groups/cooperatives',
      'Self Help Groups (SHGs)',
      'Non-Government Organizations (NGOs)',
      'State Governments/UTs',
    ],
    applicationLink: 'https://pgsindia-ncof.gov.in/pkvy.aspx',
  ),
  Scheme(
    name: 'PM Kisan Samman Nidhi',
    image: 'images/PM-KMY.jpg',
    description:
        'PM Kisan is a Central Sector scheme with 100% funding from Government of India. The scheme provides income support of Rs.6000/- per year to eligible farmer families.',
    eligibility: [
      'Small and marginal farmers with less than 2 hectares of landholding',
      'Family should consist of husband, wife and minor children',
      'All farmer families who own cultivable land can apply',
    ],
    applicationLink: 'https://pmkisan.gov.in/',
  ),
  Scheme(
    name: 'PM Fasal Bima Yojana',
    image: 'images/PMFBY.jpg',
    description:
        'PMFBY is an actuarial premium based scheme where farmer has to pay maximum 2% of sum insured for Kharif, 1.5% for Rabi food & oilseed crops and 5% for commercial/horticultural crops.',
    eligibility: [
      'All farmers growing notified crops in notified areas',
      'Sharecroppers and tenant farmers',
      'Non-Loanee farmers',
      'Loanee farmers',
    ],
    applicationLink: 'https://pmfby.gov.in/',
  ),
];
