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


db.facture.insertMany([
  { _idf: 1, idc: "Dupond", date: new Date("2023-02-01"), montant: 95, ventes: [{ idp: 1,
qte: 5 }, { idp: 4, qte: 2 }, { idp: 3, qte: 3 }], etat: "A" },
{ _idf: 2, idc: "Dupond", date: new Date("2023-03-05"), montant: 62, ventes: [{ idp:
2, qte: 4 }, { idp: 8, qte: 3 }], etat: "O" },
{ _idf: 3, idc: "Dupond", date: new Date("2023-07-10"), montant: 100, ventes: [{ idp:
7, qte: 2 }, { idp: 2, qte: 6 }, { idp: 1, qte: 5 }], etat: "O" },
{ _idf: 4, idc: "Lucas", date: new Date("2023-08-17"), montant: 52, ventes: [{ idp:
7, qte: 7 }], etat: "A" },
{ _idf: 5, idc: "Lucas", date: new Date("2023-03-20"), montant: 75, ventes: [{ idp:
1, qte: 1 }, { idp: 2, qte: 7 }], etat: "A" },
{ _idf: 6, idc: "Sophie", date: new Date("2023-03-21"), montant: 40, ventes: [{ idp:
3, qte: 2 }], etat: "O" },
{ _idf: 7, idc: "Eliot", date: new Date("2023-11-05"), montant: 45, ventes: [{ idp:
4, qte: 3 }, { idp: 2, qte: 3 }], etat: "A" },
{ _idf: 8, idc: "Eliot", date: new Date("2023-12-20"), montant: 25, ventes: [{ idp:
2, qte: 2 }, { idp: 1, qte: 1 }], etat: "O" },
{ _idf: 9, idc: "Martin", date: new Date("2023-05-10"), montant: 20, ventes: [{ idp:
5, qte: 4 }], etat: "O" },
{ _idf: 10, idc: "Martin", date: new Date("2023-11-04"), montant: 32, ventes: [{ idp:
4, qte: 2 }, { idp: 8, qte: 3 }], etat: "A" }
]);


var mapFunction = function () {
  emit(this.idc, this.montant);
};

var reduceFunction = function (key, values) {
  return Array.sum(values);
};

db.facture.mapReduce(
  mapFunction,
  reduceFunction,
  { out: { inline: 1 } }
);


db.facture.mapReduce(
  mapFunction,
  reduceFunction,
  { out: "Temp1" }
);

db.Temp1.find().sort({ '_id': 1 });

db.facture.aggregate([
  { $group: { '_id': '$idc', 'totalMontant': { $sum: '$montant' } } }
]);

var mapFunction6 = function () {
  emit(this.idc, 1);
};

var reduceFunction6 = function (key, values) {
  return Array.sum(values);
};

db.facture.mapReduce(
  mapFunction6,
  reduceFunction6,
  { out: { inline: 1 } }
);

db.facture.aggregate([
  { $group: { '_id': '$idc', 'count': { $sum: 1 } } }
]);

var mapFunction8 = function () {
  this.ventes.forEach(function (vente) {
    emit(vente.idp, 1);
  });
};

var reduceFunction8 = function (key, values) {
  return Array.sum(values);
};

db.facture.mapReduce(
  mapFunction8,
  reduceFunction8,
  { out: { inline: 1 } }
);

var mapFunction9 = function () {
  var client = this.idc;
  this.ventes.forEach(function (vente) {
    emit({ idp: vente.idp, client: client }, 1);
  });
};

var reduceFunction9 = function (key, values) {
  return Array.sum(values);
};

db.facture.mapReduce(
  mapFunction9,
  reduceFunction9,
  { out: { inline: 1 }, query: { 'idc': 'Eliot' } }
);

db.facture.aggregate([
  { $match: { 'idc': 'Eliot' } },
  { $unwind: '$ventes' },
  { $group: { '_id': { idp: '$ventes.idp', client: '$idc' }, 'count': { $sum: 1 } } }
]);

var mapFunction11 = function () {
  this.ventes.forEach(function (vente) {
    emit(vente.idp, vente.qte);
  });
};

var reduceFunction11 = function (key, values) {
  return Array.sum(values);
};

db.facture.mapReduce(
  mapFunction11,
  reduceFunction11,
  { out: { inline: 1 } }
);


var mapFunction12 = function () {
  var dateLimite = new ISODate('2023-03-10T00:00:00Z');
  this.ventes.forEach(function (vente) {
    if (this.date <= dateLimite) {
      emit(vente.idp, vente.qte);
    }
  });
};

db.facture.mapReduce(
  mapFunction12,
  reduceFunction11,
  { out: { inline: 1 } }
);


var mapFunction13 = function () {
  var dateLimite = new ISODate('2023-03-10T00:00:00Z');
  this.ventes.forEach(function (vente) {
    if (this.date <= dateLimite) {
      emit(vente.idp, { total: vente.qte, count: 1 });
    }
  });
};

var reduceFunction13 = function (key, values) {
  var reduced = { total: 0, count: 0 };
  values.forEach(function (value) {
    reduced.total += value.total;
    reduced.count += value.count;
  });
  return reduced;
};

var finalizeFunction13 = function (key, reduced) {
  return reduced.total / reduced.count;
};

db.facture.mapReduce(
  mapFunction13,
  reduceFunction13,
  { out: { inline: 1 }, finalize: finalizeFunction13 }
);