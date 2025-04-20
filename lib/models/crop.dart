class CropVariety {
  final String name;
  final String description;
  final double seedPrice;
  final String growingSeason;
  final String expectedYield;

  CropVariety({
    required this.name,
    required this.description,
    required this.seedPrice,
    required this.growingSeason,
    required this.expectedYield,
  });
}

class GrowingTips {
  final String bestPlantingSeason;
  final String recommendedSoilType;
  final String waterRequirements;

  GrowingTips({
    required this.bestPlantingSeason,
    required this.recommendedSoilType,
    required this.waterRequirements,
  });
}

class CropCategory {
  final String name;
  final String image;
  final String description;
  final double currentPrice;
  final List<CropVariety> varieties;
  final GrowingTips growingTips;

  CropCategory({
    required this.name,
    required this.image,
    required this.description,
    required this.currentPrice,
    required this.varieties,
    required this.growingTips,
  });
}

// Sample crop data
final List<CropCategory> cropCategories = [
  CropCategory(
    name: 'Wheat',
    image: 'images/wheat.png',
    description:
        'Wheat is a cereal grain that is grown worldwide. It is the third most-produced cereal after maize and rice. Wheat is a key source of carbohydrates and protein.',
    currentPrice: 2275.0,
    varieties: [
      CropVariety(
        name: 'HD 2967',
        description:
            'High-yielding variety with good disease resistance. Suitable for irrigated conditions.',
        seedPrice: 45,
        growingSeason: "October-November (Rabi)",
        expectedYield: "45-50",
      ),
      CropVariety(
        name: 'HD 3086',
        description:
            'Drought-tolerant variety with excellent grain quality. Ideal for rainfed conditions.',
        seedPrice: 42,
        growingSeason: "October-November (Rabi)",
        expectedYield: "40-45",
      ),
      CropVariety(
        name: 'PBW 723',
        description:
            'Early maturing variety with high protein content. Good for late sowing.',
        seedPrice: 48,
        growingSeason: "October-November (Rabi)",
        expectedYield: "42-47",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Rabi (October-November)",
      recommendedSoilType: "Well-drained loamy soil with pH 6.0-7.5",
      waterRequirements: "4-5 irrigations during growing season",
    ),
  ),
  CropCategory(
    name: 'Millet',
    image: 'images/plant.png',
    description:
        'Millets are a group of highly variable small-seeded grasses, widely grown around the world as cereal crops or grains for fodder and human food. They are known for their drought tolerance and nutritional value.',
    currentPrice: 2800.0,
    varieties: [
      CropVariety(
        name: 'Bajra',
        description:
            'Pearl millet variety with high drought resistance. Early maturing.',
        seedPrice: 85,
        growingSeason: "June-July (Kharif)",
        expectedYield: "20-25",
      ),
      CropVariety(
        name: 'Jowar',
        description:
            'Sorghum variety with good grain quality. Medium duration.',
        seedPrice: 75,
        growingSeason: "June-July (Kharif)",
        expectedYield: "25-30",
      ),
      CropVariety(
        name: 'Ragi',
        description: 'Finger millet with high calcium content. Long duration.',
        seedPrice: 90,
        growingSeason: "June-July (Kharif)",
        expectedYield: "15-20",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Kharif (June-July)",
      recommendedSoilType: "Well-drained sandy loam soil with pH 6.0-7.5",
      waterRequirements: "Minimal irrigation, drought-tolerant crop",
    ),
  ),
  CropCategory(
    name: 'Rice',
    image: 'images/rice.png',
    description:
        'Rice is the most widely consumed staple food for a large part of the world\'s human population, especially in Asia. It is the agricultural commodity with the third-highest worldwide production.',
    currentPrice: 3850.0,
    varieties: [
      CropVariety(
        name: 'IR 36',
        description:
            'High-yielding variety with good disease resistance. Early maturing.',
        seedPrice: 55,
        growingSeason: "June-July (Kharif)",
        expectedYield: "55-60",
      ),
      CropVariety(
        name: 'Swarna',
        description:
            'Popular variety with excellent grain quality. Medium duration.',
        seedPrice: 60,
        growingSeason: "June-July (Kharif)",
        expectedYield: "50-55",
      ),
      CropVariety(
        name: 'Samba Mahsuri',
        description:
            'Aromatic variety with premium grain quality. Long duration.',
        seedPrice: 65,
        growingSeason: "June-July (Kharif)",
        expectedYield: "45-50",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Kharif (June-July)",
      recommendedSoilType: "Clay or clay loam soil with good water retention",
      waterRequirements: "Continuous standing water of 5-10 cm depth",
    ),
  ),
  CropCategory(
    name: 'Pulses',
    image: 'images/beans.png',
    description:
        'Pulses are the edible seeds of plants in the legume family. They are high in protein, fiber, and various vitamins and minerals. India is the largest producer and consumer of pulses in the world.',
    currentPrice: 4800.0,
    varieties: [
      CropVariety(
        name: 'Arhar Dal (Pigeon Pea)',
        description:
            'Popular pulse with high protein content. Medium duration.',
        seedPrice: 120,
        growingSeason: "June-July (Kharif)",
        expectedYield: "12-15",
      ),
      CropVariety(
        name: 'Toor Dal (Yellow Pigeon Pea)',
        description:
            'High-yielding variety with good grain quality. Early maturing.',
        seedPrice: 110,
        growingSeason: "June-July (Kharif)",
        expectedYield: "15-18",
      ),
      CropVariety(
        name: 'Moong Dal (Green Gram)',
        description:
            'Short duration pulse with high nutritional value. Early maturing.',
        seedPrice: 95,
        growingSeason: "March-April or June-July",
        expectedYield: "8-10",
      ),
      CropVariety(
        name: 'Urad Dal (Black Gram)',
        description:
            'High protein content with good grain quality. Medium duration.',
        seedPrice: 100,
        growingSeason: "June-July (Kharif)",
        expectedYield: "10-12",
      ),
      CropVariety(
        name: 'Masoor Dal (Red Lentil)',
        description: 'Early maturing variety with good yield. Short duration.',
        seedPrice: 85,
        growingSeason: "October-November (Rabi)",
        expectedYield: "12-15",
      ),
      CropVariety(
        name: 'Chana Dal (Bengal Gram)',
        description:
            'Drought-tolerant variety with high protein content. Medium duration.',
        seedPrice: 90,
        growingSeason: "October-November (Rabi)",
        expectedYield: "15-18",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Kharif (June-July) or Rabi (October-November)",
      recommendedSoilType: "Well-drained loamy soil with pH 6.0-7.5",
      waterRequirements:
          "Moderate irrigation, especially during flowering and pod formation",
    ),
  ),
  CropCategory(
    name: 'Maize',
    image: 'images/corn.png',
    description:
        'Maize, also known as corn, is a cereal grain first domesticated by indigenous peoples in southern Mexico about 10,000 years ago. It is used for food, feed, and industrial products.',
    currentPrice: 1850.0,
    varieties: [
      CropVariety(
        name: 'HQPM 1',
        description:
            'High-quality protein maize variety. Good for both food and feed.',
        seedPrice: 180,
        growingSeason: "Year-round (varies by region)",
        expectedYield: "65-70",
      ),
      CropVariety(
        name: 'Pusa Early Hybrid',
        description:
            'Early maturing hybrid with high yield potential. Good for summer cultivation.',
        seedPrice: 200,
        growingSeason: "Year-round (varies by region)",
        expectedYield: "70-75",
      ),
      CropVariety(
        name: 'DHM 117',
        description:
            'Disease-resistant variety with good grain quality. Suitable for all seasons.',
        seedPrice: 190,
        growingSeason: "Year-round (varies by region)",
        expectedYield: "60-65",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Year-round (varies by region)",
      recommendedSoilType: "Well-drained fertile soil with pH 5.5-7.0",
      waterRequirements:
          "Regular irrigation, especially during flowering and grain filling",
    ),
  ),
  CropCategory(
    name: 'Mustard',
    image: 'images/mustard.png',
    description:
        'Mustard is an oilseed crop that is widely grown for its seeds which are used to produce mustard oil. It is an important Rabi crop in India and is known for its high oil content.',
    currentPrice: 5500.0,
    varieties: [
      CropVariety(
        name: 'RH 749',
        description:
            'High-yielding variety with good oil content. Early maturing.',
        seedPrice: 450,
        growingSeason: "October-November (Rabi)",
        expectedYield: "20-25",
      ),
      CropVariety(
        name: 'Giriraj',
        description:
            'Disease-resistant variety with high oil recovery. Medium duration.',
        seedPrice: 420,
        growingSeason: "October-November (Rabi)",
        expectedYield: "18-22",
      ),
      CropVariety(
        name: 'Varuna',
        description: 'Popular variety with good grain quality. Long duration.',
        seedPrice: 380,
        growingSeason: "October-November (Rabi)",
        expectedYield: "15-18",
      ),
    ],
    growingTips: GrowingTips(
      bestPlantingSeason: "Rabi (October-November)",
      recommendedSoilType: "Well-drained loamy soil with pH 6.0-7.5",
      waterRequirements: "2-3 irrigations during growing season",
    ),
  ),
];
