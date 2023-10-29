// Select the database to use.
use('mongodbVSCodePlaygroundDB');

// Insert a few documents into the sales collection.
db.getCollection('orders').insertMany([
  { 'item': 'abc', 'price': 10, 'quantity': 2, 'date': new Date('2023-03-01T08:00:00Z') },
  { 'item': 'jkl', 'price': 20, 'quantity': 1, 'date': new Date('2023-03-01T09:00:00Z') },
  { 'item': 'xyz', 'price': 5, 'quantity': 10, 'date': new Date('2023-03-15T09:00:00Z') },
  { 'item': 'xyz', 'price': 5, 'quantity': 20, 'date': new Date('2023-04-04T11:21:39.736Z') },
  { 'item': 'abc', 'price': 10, 'quantity': 10, 'date': new Date('2023-04-04T21:23:13.331Z') },
  { 'item': 'def', 'price': 7.5, 'quantity': 5, 'date': new Date('2022-06-04T05:08:13Z') },
  { 'item': 'def', 'price': 7.5, 'quantity': 10, 'date': new Date('2022-09-10T08:43:00Z') },
  { 'item': 'abc', 'price': 10, 'quantity': 5, 'date': new Date('2022-02-06T20:20:13Z') },
]);

// Run a find command to view items sold on April 4th, 2014.
const ordersOnApril4th = db.getCollection('orders').find({
  date: { $gte: new Date('2023-04-04'), $lt: new Date('2023-04-05') }
}).count();

// Print a message to the output window.
console.log(`${ordersOnApril4th} sales occurred in 2023.`);

//sales
db.getCollection('orders').aggregate([
  // Find all of the orders that occurred in 2023
  { $match: { date: { $gte: new Date('2022-01-01'), $lt: new Date('2023-01-01') } } },
  // Group the total orders for each product.
  { $group: { _id: '$item', totalOrderAmount: { $sum: { $multiply: [ '$price', '$quantity' ] } } } }
]);
