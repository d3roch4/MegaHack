class Titulo {
  String code;
  double beta;
  double sale_price;
  double purchase_price;
  double liquids;
  double return_rate;
  String image;
  String name;
  String categories;
  String description;
  List<String> recomentations;
  bool favorite;
  int quantity_purchased;
  double classification;
  int objetivos;

  Titulo({
    this.code,
    this.image,
    this.name,
    this.categories,
    this.description,
    this.recomentations,
    this.beta = 0,
    this.sale_price = 0,
    this.purchase_price = 0,
    this.liquids = 0,
    this.return_rate = 0,
    this.quantity_purchased = 0,
    this.favorite = false,
    this.classification = 0,
    this.objetivos,
  });
}

final List<Titulo> destaques = [
  Titulo(
    code: 'MGLU3',
    image: 'https://agorarn.com.br/files/uploads/2020/09/magazine-luiza-2.jpg',
    name: 'Magazine Luiza',
    categories: 'Marketplace, varejo',
    sale_price: 25.67,
    liquids: 6.42,
    return_rate: 4.96,
    description:
    'O Magazine Luiza é uma empresa de varejo que atua com lojas físicas e no e-commerce. Atualmente a companhia possui 900 lojas físicas. O marketplace da marca reúne mais de 8 mil sellers. A empresa também é dona das plataformas Netshoes, Zattini e Shoestock. Além do varejo, a empresa ainda atua com produtos financeiros. São eles o cartão de crédito Luizacred, o seguro Luizaseg e o Consórcio Luiza. Desde 2011, o Magazine Luiza faz parte do Novo Mercado da B3, a bolsa de valores de São Paulo. Há vinte anos, integra a lista das melhores empresas para trabalhar no Brasil e por dois anos consecutivos foi considerada a número 1 do varejo.',
    recomentations: [
      'https://www.youtube.com/watch?v=LiEWbl_NBVM&ab_channel=daltonvieira.com',
      'https://www.youtube.com/watch?v=uCLDKoXuHE8&ab_channel=InvestimentoemA%C3%87%C3%83O',
      'https://www.youtube.com/watch?v=Mz1Moo9L38w&ab_channel=CanaldoHolder',
    ],
  ),
  Titulo(
    code: 'ABEV3',
    image: 'https://cdn.tororadar.com.br/analista/seo/2016-9-16/91308a03a3f4b4308e8d0e2610d3f178a559d746/analise-abev3-2016.png',
    name: 'AMBEV S/A',
    categories: 'Consumo não Cíclico / Bebidas / Cervejas e Refrigerantes',
    sale_price: 25.67,
    liquids: 6.42,
    return_rate: 4.96,
    description: 'A Companhia de Bebidas das Américas – Ambev é a sucessora da Companhia Cervejaria Brahma (“Brahma”) e da Companhia Antarctica Paulista Indústria Brasileira de Bebidas e Conexos (“Antarctica”), duas das cervejarias mais antigas do Brasil. A Antarctica foi fundada em 1885 e a Brahma em 1888, como Villiger & Cia. A marca Brahma foi registrada em 6 de setembro de 1888 e, em 1904, a Villiger & Cia. mudou sua denominação para Companhia Cervejaria Brahma. A Ambev foi constituída como Aditus Participações S.A. (“Aditus”) em 14 de setembro de 1998. A Ambev é uma sociedade anônima brasileira, de capital aberto, constituída segundo as leis da República Federativa do Brasil.',
    recomentations: [
      'https://www.youtube.com/watch?v=LiEWbl_NBVM&ab_channel=daltonvieira.com',
      'https://www.youtube.com/watch?v=uCLDKoXuHE8&ab_channel=InvestimentoemA%C3%87%C3%83O',
      'https://www.youtube.com/watch?v=Mz1Moo9L38w&ab_channel=CanaldoHolder',
    ],
  ),
  Titulo(
    code: 'AZUL4',
    image: 'https://plataformafasttrade.com.br/wp-content/uploads/2018/11/azul-700x300.png',
    name: 'AZUL',
    categories: 'Consumo não Cíclico / Bebidas / Cervejas e Refrigerantes',
    sale_price: 25.67,
    liquids: 6.42,
    return_rate: 4.96,
    description: 'Somos a companhia aérea que mais cresceu no Brasil desde que iniciamos nossas operações em dezembro de 2008, contando atualmente com a maior malha aérea do país atendendo mais de 100 destinos com 792 decolagens diárias. Além disso, expandimos nossas operações com voos diretos para os Estados Unidos e Portugal, operando com as aeronaves A330 equipadas com o mais tecnológico sistema de entretenimento a bordo, refeições feitas especialmente para as classes Business e Economy. Além disso, mais rotas internacionais são operadas pela Azul: Buenos Aires, Punta Del Este, Montevidéu e Caiena.',
    recomentations: [
      'https://www.youtube.com/watch?v=LiEWbl_NBVM&ab_channel=daltonvieira.com',
      'https://www.youtube.com/watch?v=uCLDKoXuHE8&ab_channel=InvestimentoemA%C3%87%C3%83O',
      'https://www.youtube.com/watch?v=Mz1Moo9L38w&ab_channel=CanaldoHolder',
    ],
  ),
];

final List<String> labels = [
  'Discover',
  'Categories',
  'Specials',
  'New',
];

final List<String> myList = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
];

final List<String> popular = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Empty_Star.svg/768px-Empty_Star.svg.png',
];
