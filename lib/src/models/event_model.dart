class EventModel {
  final String name;
  final String date;
  final String time;
  final String description;
  final String organizer;
  final String locationName;
  final String locationAddress;
  final String image;
  final String type;

  EventModel({
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.organizer,
    required this.locationName,
    required this.locationAddress,
    required this.image,
    required this.type,
  });
}

final List<EventModel> events = [
  EventModel(
    name: "World Wetlands Day",
    date: "February 2",
    time: "All Day",
    description:
        "World Wetlands Day is an annual global observance on February 2nd to raise awareness about wetlands' vital role for people and the planet, marking the anniversary of the 1971 Ramsar Convention, an international treaty for wetland conservation. Celebrated since 1997, it highlights wetlands as crucial ecosystems for biodiversity, water resources, and climate change adaptation, urging action to stop their rapid loss. Each year features a specific theme, like \"Protecting Wetlands for Our Common Future\" (2025), encouraging governments, organizations, and individuals to protect and restore these important areas. ",
    organizer: "Ramsar Convention",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_wetlands_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "Earth Day",
    date: "April 22",
    time: "All Day",
    description:
        "Earth Day is an annual event on April 22 to demonstrate support for environmental protection. First held on April 22, 1970, it now includes a wide range of events coordinated globally through earthday.org including 1 billion people in more than 193 countries. \n\n In 1969 at a UNESCO conference in San Francisco, peace activist John McConnell proposed a day to honor the Earth and the concept of peace, to first be observed on March 21, 1970, the first day of spring in the northern hemisphere. This day of nature's equipoise was later sanctioned in a proclamation written by McConnell and signed by Secretary General U Thant at the United Nations. A month later, United States senator Gaylord Nelson proposed the idea to hold a nationwide environmental teach-in on April 22, 1970, and hired a young activist, Denis Hayes, to be the national coordinator. The name \"Earth Day\" was coined by advertising writer Julian Koenig. Denis and his staff grew the event beyond the original idea for a teach-in to include the entire United States.",
    organizer: "EarthDay.org",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "earth_day.jpeg",
    type: "global",
  ),
  EventModel(
    name: "International Day for Biological Diversity",
    date: "May 22",
    time: "All Day",
    description:
        "The International Day for Biological Diversity (IDB) is celebrated annually on May 22nd to raise awareness about biodiversity issues and promote the conservation of Earth's variety of life, commemorating the adoption of the Convention on Biological Diversity (CBD) in 1992 by the United Nations. Coordinated by the CBD secretariat, it's a global call to action to protect ecosystems, with themes focusing on sustainable development and the connection between nature, human well-being, and global goals like the Sustainable Development Goals (SDGs). ",
    organizer: "United Nations",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "biodiversity_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "World Environment Day",
    date: "June 5",
    time: "All Day",
    description:
        "World Environment Day (WED) is celebrated annually on 5 June and encourages awareness and action for the protection of the environment. It is supported by many non-governmental organizations, businesses, government entities, and represents the primary United Nations outreach day supporting the environment.\n\nFirst held in 1973, it has been a platform for raising awareness on environmental issues as marine pollution, overpopulation, global warming, sustainable development and wildlife crime. World Environment Day is a global platform for public outreach, with participation from over 143 countries annually, incl. participation from Argentina, Australia, Austria, Brazil, Canada, Chile, Denmark, Finland, France, Germany, India, Israel, Italy, Japan, Mexico, the Netherlands, Norway, the Philippines, Poland, South Africa, Spain, Switzerland, Thailand and the United States.[citation needed] Every year, the program has provided a theme and forum for businesses, non government organizations, communities, politicians and stars to advocate environmental causes.",
    organizer: "UNEP",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_environment_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "World Oceans Day",
    date: "June 8",
    time: "All Day",
    description:
        "World Ocean Day (WOD) is an international day that takes place annually on June 8. The concept was originally proposed in 1992 by Canada's International Centre for Ocean Development (ICOD) and the Ocean Institute of Canada (OIC) at the Earth Summit – UN Conference on Environment and Development (UNCED) in Rio de Janeiro, Brazil. The Ocean Project started global coordination of World Ocean Day starting in 2002. \"World Oceans Day\" was officially recognized by the United Nations in 2008. The international day supports the implementation of worldwide Sustainable Development Goals (SDGs) and fosters public interest in the protection of the ocean and the sustainable management of its resources. World Oceans Day is observed by all UN member states.",
    organizer: "UNESCO/UN",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_oceans_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "International Coastal Cleanup Day",
    date: "Third Saturday of September",
    time: "Morning – Afternoon",
    description:
        "International Coastal Cleanup Day (ICCD) is a global event held annually on the third Saturday of September, where millions of volunteers clean beaches and waterways, removing trash and collecting data to combat marine pollution, a movement started by the Ocean Conservancy in 1986 to raise awareness and support policy changes for healthier oceans. ",
    organizer: "Ocean Conservancy",
    locationName: "Worldwide Beaches",
    locationAddress: "Global",
    image: "coastal_cleanup.png",
    type: "global",
  ),
  EventModel(
    name: "International Day of Forests",
    date: "March 21",
    time: "All Day",
    description:
        "The International Day of Forests, the 21st day of March, was established by resolution of the United Nations General Assembly on 28 November 2012. Each year, various events celebrate and raise awareness of the importance of all types of forests, and trees outside forests, for the benefit of current and future generations. Countries are encouraged to undertake efforts to organize local, national, and international activities involving forests and trees, such as tree planting campaigns, on International Day of Forests. The Secretariat of the United Nations Forum on Forests, in collaboration with the Food and Agriculture Organization, facilitates the implementation of such events in collaboration with governments, the Collaborative Partnership on Forests, and international, regional and subregional organizations. The day was observed for the first time on 21 March 2013.",
    organizer: "United Nations",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "international_day_of_forests.jpg",
    type: "global",
  ),
  EventModel(
    name: "World Water Day",
    date: "March 22",
    time: "All Day",
    description:
        "World Water Day is an annual UN observance on March 22nd, focusing on freshwater's importance, raising awareness about water crises, and promoting sustainable management (SDG 6). Celebrated since 1993, it features themes like 2025's \"Glacier Preservation,\" highlighting climate change impacts, encouraging global action on water security, and tackling the billions lacking clean water access. ",
    organizer: "United Nations",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_water_day.png",
    type: "global",
  ),
  EventModel(
    name: "World Meteorological Day",
    date: "March 23",
    time: "All Day",
    description:
        "World Meteorological Day was established in 1951 to commemorate the establishment of the World Meteorological Organization on 23 March 1950. This organization announces a slogan for World Meteorological Day every year, and this day is celebrated in all member countries.\n\nThe World Meteorological Organisation (WMO), an organization of the United Nations, was created on 23 March 1950 to replace the International Meteorological Organization. It began operations in 1951 to coordinate member nations in the fields of meteorology, operational hydrology, and Earth sciences for the security of their population. The first World Meteorological Day was held on 23 March 1961.",
    organizer: "World Meteorological Organization (WMO)",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_meteorological_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "Earth Hour",
    date: "Last Saturday of March",
    time: "08:30 PM – 09:30 PM",
    description:
        "Earth Hour is a worldwide movement organized by the World Wildlife Fund (WWF). The event is held annually, encouraging the individuals, communities, and businesses to give an hour for Earth, and additionally marked by landmarks and businesses switching off non-essential electric lights, for one hour from 8:30 to 9:30p.m., usually on the last Saturday of March, as a symbol of commitment to the planet.It was started as a lights-off event in Sydney, New South Wales, Australia, in 2007.\n\nOccasionally, in years when Holy Saturday falls on the last Saturday of March (as in 2024), Earth Hour is held a week earlier.",
    organizer: "World Wide Fund for Nature (WWF)",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "earth_hour.png",
    type: "global",
  ),
  EventModel(
    name: "World Nature Conservation Day",
    date: "July 28",
    time: "All Day",
    description:
        "World Nature Conservation Day is observed annually on July 28th to raise global awareness about protecting natural resources, preserving ecosystems, and combating issues like climate change, pollution, and biodiversity loss, urging everyone to adopt sustainable practices for a healthier planet and future generations. It emphasizes that a healthy environment is the foundation for a stable society and calls for action to conserve vital resources like water, air, soil, plants, and wildlife.",
    organizer: "International Conservation Organizations",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_nature_conservation_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "Clean Air for Blue Skies",
    date: "September 7",
    time: "All Day",
    description:
        "\"Clean Air for Blue Skies\" refers to the International Day of Clean Air for Blue Skies, designated by the UN for September 7th annually, to raise global awareness and action against air pollution, highlighting its severe health impacts and strong links to climate change, urging better policies, renewable energy, and cross-sector collaboration to ensure everyone's right to breathe clean air. ",
    organizer: "United Nations",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "clean_air_blue_skies.jpg",
    type: "global",
  ),
  EventModel(
    name: "World Ozone Day",
    date: "September 16",
    time: "All Day",
    description:
        "International Day for the Preservation of the Ozone Layer (informally and simply called Ozone Day) is celebrated on September 16 designed by the United Nations General Assembly. This designation had been made on December 19, 2000, in commemoration of the date, in 1987, on which nations signed the Montreal Protocol on Substances that Deplete the Ozone Layer. In 1994, the UN General Assembly proclaimed 16 September the International Day for the Preservation of the Ozone Layer, commemorating the date of the signing, in 1987, of the Montreal Protocol on Substances that Deplete the Ozone Layer. The closure of the hole in the ozone layer was observed 30 years after the protocol was signed. Due to the nature of the gases responsible for ozone depletion their chemical effects are expected to continue for between 50 and 100 years.",
    organizer: "United Nations Environment Programme (UNEP)",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_ozone_day.jpg",
    type: "global",
  ),
  EventModel(
    name: "World Cleanup Day",
    date: "Third Saturday of September",
    time: "Morning – Afternoon",
    description:
        "World Cleanup Day is an annual, global social action event held on September 20th that unites millions of volunteers in over 190 countries to tackle waste and pollution in beaches, forests, rivers, and cities, fostering community action for a cleaner, waste-free planet, and is now an official United Nations observance. Organized by Let's Do It! World, it involves cleanups and waste mapping, aiming to create systemic change and promote sustainable habits.",
    organizer: "Let’s Do It World",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_cleanup_day.png",
    type: "global",
  ),
  EventModel(
    name: "World Animal Day",
    date: "October 4",
    time: "All Day",
    description:
        "World Animal Day is an international day of action for animal rights and welfare celebrated annually on October 4, the feast day of Francis of Assisi, the patron saint of animals.\n\nThe World Animal Day movement is supported and endorsed by a number of celebrities, such as Anneka Svenska, Brian Blessed and Melanie C.",
    organizer: "World Animal Day Organization",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_animal_day.png",
    type: "global",
  ),
  EventModel(
    name: "World Soil Day",
    date: "December 5",
    time: "All Day",
    description:
        "World Soil Day (WSD) is celebrated annually on December 5th to raise global awareness about the importance of healthy soils for food security, ecosystem functions, and human well-being, advocating for their sustainable management. Established by the United Nations and facilitated by the Food and Agriculture Organization (FAO), the day highlights soil's role in water regulation, nutrient cycling, and carbon storage, with the 2025 theme focusing on \"Healthy Soils for Healthy Cities\".",
    organizer: "Food and Agriculture Organization (FAO)",
    locationName: "Worldwide",
    locationAddress: "Global",
    image: "world_soil_day.png",
    type: "global",
  ),
  // Local Events
  EventModel(
    name: "Yangon River Clean-Up",
    date: "We will notify",
    time: "We will notify",
    description:
        "Local volunteers gather to clean debris along the Yangon River and promote healthy waterways.",
    organizer: "We will notify!",
    locationName: "--",
    locationAddress: "",
    image: "env.jpeg",
    type: "local",
  ),
  EventModel(
    name: "Mandalay Tree Planting Day",
    date: "We will notify",
    time: "We will notify",
    description:
        "Community tree planting event to grow green spaces throughout Mandalay.",
    organizer: "We will notify!",
    locationName: "--",
    locationAddress: "",
    image: "env.jpeg",
    type: "local",
  ),
  EventModel(
    name: "Inle Lake Eco-Awareness Festival",
    date: "We will notify",
    time: "We will notify",
    description:
        "Festival with workshops on freshwater conservation, traditional boat races, and eco-market stalls.",
    organizer: "We will notify!",
    locationName: "--",
    locationAddress: "",
    image: "env.jpeg",
    type: "local",
  ),
  EventModel(
    name: "Sagaing Clean Air Walk",
    date: "We will notify",
    time: "We will notify",
    description:
        "Awareness walk promoting clean air, healthy transport, and emission reduction.",
    organizer: "We will notify!",
    locationName: "--",
    locationAddress: "",
    image: "env.jpeg",
    type: "local",
  ),
  EventModel(
    name: "Rakhine Beach Plastic Patrol",
    date: "We will notify",
    time: "We will notify",
    description:
        "Volunteer beach clean-up focused on reducing plastic pollution along the Rakhine coastline.",
    organizer: "We will notify!",
    locationName: "--",
    locationAddress: "",
    image: "env.jpeg",
    type: "local",
  ),
];
