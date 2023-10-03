db.getCollection("produit").find({})
db.produit.insertMany([
    { '_id': 1, 'libelle': 'chou', 'prixU': 5, 'qte': 7, 'dateFab': new Date('2022-03-01T08:00:00Z') },
    { '_id': 2, 'libelle': 'tomate', 'prixU': 10, 'qte': 2, 'dateFab': new Date('2021-03-01T08:00:00Z') },
    { '_id': 3, 'libelle': 'oignon', 'prixU': 20, 'qte': 1, 'dateFab': new Date('2021-03-01T09:00:00Z') },
    { '_id': 4, 'libelle': 'salade', 'prixU': 5, 'qte': 10, 'dateFab': new Date('2021-03-15T09:00:00Z') },
    { '_id': 5, 'libelle': 'tomate', 'prixU': 5, 'qte': 20, 'dateFab': new Date('2021-04-04T11:21:39.736Z') },
    { '_id': 6, 'libelle': 'chou', 'prixU': 10, 'qte': 10, 'dateFab': new Date('2021-04-04T21:23:13.331Z') },
    { '_id': 7, 'libelle': 'oignon', 'prixU': 7.5, 'qte': 5, 'dateFab': new Date('2022-06-04T05:08:13Z') },
    { '_id': 8, 'libelle': 'tomate', 'prixU': 7.5, 'qte': 10,'dateFab': new Date('2022-09-10T08:43:00Z')},
    { '_id': 9, 'libelle': 'tomate', 'prixU': 10, 'qte': 5, 'dateFab':new Date('2023-02-06T20:20:13Z') }
]);
db.getCollection("vendeur").find({})
db.vendeur.insertMany([
    {'_id':'f1','nom':'Alfred','statut':20,'ville':'Londres','ventes':[{ '_id': 1, 'qte': 7, 'date': new Date('2022-03-01T08:00:00Z') },{ '_id': 2, 'qte': 2, 'date': new Date('2021-03-01T08:00:00Z')}]},
    {'_id':'f2','nom':'Robert','statut':10,'ville':'Paris','ventes':[{ '_id': 3, 'qte': 1, 'date': new Date('2021-03-01T09:00:00Z') },{ '_id': 4, 'qte': 10, 'date': new Date('2021-03-15T09:00:00Z')},
    { '_id': 1, 'qte': 2, 'date': new Date('2022-05-16T10:00:00Z')},{ '_id': 7, 'qte': 4, 'date': new Date('2022-03-01T09:00:00Z') }]},
    {'_id':'f3','nom':'Raymonde','statut':30,'ville':'Paris','ventes':[
    { '_id': 2, 'qte': 20, 'date': new Date('2021-04-04T11:21:39.736Z') },
    { '_id': 1, 'qte': 10, 'date': new Date('2021-04-04T21:23:13.331Z') },
    { '_id': 4, 'qte': 7, 'date': new Date('2022-010-23T21:23:13.331Z') },
    { '_id': 5, 'qte': 12, 'date': new Date('2022-09-21T21:23:13.331Z') },
    ]},
    {'_id':'f4','nom':'Gaston','statut':20,'ville':'Londres','ventes':[
    { '_id': 3, 'qte': 5, 'date': new Date('2022-06-04T05:08:13Z') },
    { '_id': 2, 'qte': 10, 'date': new Date('2022-09-10T08:43:00Z') }]},
    {'_id':'f5','nom':'Hector','statut':30,'ville':'Nantes',
    'ventes':[{ '_id': 2, 'qte': 5, 'date': new Date('2023-02-06T20:20:13Z') }]}
]);

db.produit.insertOne({ '_id': 1, 'libelle': 'orange', 'prixU': 20, 'dateFab': new Date('2023-02-06T20:20:13Z') });

db.produit.updateOne({ '_id': 1 }, { $set: { 'etat': 'Frais' } });

db.produit.updateOne({ '_id': 1 }, { $unset: { 'etat': 1 } });

db.produit.deleteOne({ '_id': 1 });

db.produit.drop();

db.produit.insertOne({ '_id': 1, 'libelle': 'chou', 'prixU': 5, 'qte': 7, 'dateFab': new Date('2022-03-01T08:00:00Z') });

db.produit.replaceOne({ '_id': 1 }, { 'libelle': 'Orange', 'prixU': 5, 'qte': 7, 'dateFab': new Date('2022-03-01T08:00:00Z') });

db.produit.find({ 'prixU': { $gt: 10 } }, { 'libelle': 1, '_id': 0 })

db.produit.find();

db.produit.count();

db.produit.find({ 'dateFab': { $gte: new Date('2021-04-03'), $lte: new Date('2023-04-05') } });

db.produit.find({ 'libelle': { $ne: 'tomate' } });

db.produit.find({ $expr: { $lt: [{ $strLenCP: '$libelle' }, 5] } }, { 'prixU': 1, '_id': 0 });

db.produit.aggregate([
  { $match: { 'libelle': 'chou' } },
  { $project: { 'prixU': 1, 'dateFab': 1, '_id': 0 } }
]);

db.produit.aggregate([
  { $project: { 'sommePrix': { $multiply: ['$qte', '$prixU'] } } },
  { $group: { '_id': null, 'total': { $sum: '$sommePrix' } } }
]);

db.produit.aggregate([
  { $group: { '_id': '$libelle', 'prixMoyen': { $avg: '$prixU' } } }
]);

db.vendeur.find();

db.vendeur.find().sort({ 'nom': 1, '_id': -1 });

db.vendeur.find({ 'ville': { $in: ['Paris', 'Londres'] } });

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $group: { '_id': null, 'totalVentes': { $sum: '$ventes.qte' } } }
]);

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $group: { '_id': '$_id', 'totalVentes': { $sum: 1 } } }
]);

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $match: { 'ventes._id': 3 } },
  { $group: { '_id': '$_id', 'totalVentesProduit3': { $sum: '$ventes.qte' } } }
]);

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $match: { 'ventes._id': { $in: [2, 3] } } },
  { $group: { '_id': '$_id', 'count': { $sum: 1 } } },
  { $match: { 'count': { $eq: 2 } } }
]);

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $group: { '_id': '$_id', 'distinctProducts': { $addToSet: '$ventes._id' } } },
  { $match: { 'distinctProducts': { $size: 2 } } },
  { $count: 'totalVendeurs' }
]);

db.vendeur.aggregate([
  { $group: { '_id': '$ville', 'nombreVendeurs': { $sum: 1 } } }
]);

db.vendeur.aggregate([
  { $unwind: '$ventes' },
  { $lookup: { from: 'produit', localField: 'ventes._id', foreignField: '_id', as: 'produitInfo' } },
  { $match: { 'produitInfo.libelle': 'chou' } },
  { $project: { 'nom': 1, '_id': 0 } }
]);