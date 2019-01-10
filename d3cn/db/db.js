var mongoose = require('mongoose');
mongoose.Promise = require('bluebird');
mongoose.connect('mongodb://' + process.env.MONGODB_CONNECTION, { useMongoClient: true });

module.exports = {
};